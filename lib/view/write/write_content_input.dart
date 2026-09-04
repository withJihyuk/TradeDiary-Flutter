part of 'write_page.dart';

const bool _kImeStyleDebugLogs = false;
const double _kEditorLineHeight = 1.8;

void _imeStyleLog(String message) {
  if (!_kImeStyleDebugLogs) return;
  debugPrint('[IME_STYLE] $message');
}

void _imeStyleLogLazy(String Function() builder) {
  if (!_kImeStyleDebugLogs) return;
  debugPrint('[IME_STYLE] ${builder()}');
}

String _selectionLog(TextSelection sel) {
  return 'sel(base:${sel.baseOffset}, extent:${sel.extentOffset}, '
      'collapsed:${sel.isCollapsed}, valid:${sel.isValid})';
}

String _styleLog(Style style) {
  if (style.isEmpty) return '{}';
  final pairs = style.attributes.entries
      .map((e) => '${e.key}:${e.value.value}')
      .join(', ');
  return '{$pairs}';
}

Style _inlineStyleOnly(Style style) {
  var result = const Style();
  for (final entry in style.attributes.entries) {
    if (Attribute.inlineKeys.contains(entry.key)) {
      result = result.put(entry.value);
    }
  }
  return result;
}

Style _mergeInlinePreserveNull(Style base, Style overlay) {
  final merged = <String, Attribute>{...base.attributes, ...overlay.attributes};
  return Style.attr(merged);
}

void _rememberInlineIntent(
  WidgetRef ref,
  QuillController controller,
  Attribute attribute,
) {
  if (!Attribute.inlineKeys.contains(attribute.key)) return;
  final selection = controller.selection;
  if (!selection.isValid ||
      !selection.isCollapsed ||
      selection.baseOffset < 0) {
    _imeStyleLogLazy(
      () =>
          'rememberIntent skip attr(${attribute.key}:${attribute.value}) '
          '${_selectionLog(selection)}',
    );
    return;
  }

  final caretIndex = selection.baseOffset.clamp(
    0,
    controller.document.length - 1,
  );
  final base = _inlineStyleOnly(
    controller.document.collectStyle(caretIndex, 0),
  );
  final overlay = _inlineStyleOnly(Style.attr({attribute.key: attribute}));
  final intentStyle = _mergeInlinePreserveNull(base, overlay);

  ref.read(inlineTypingStyleProvider.notifier).state = intentStyle;
  ref.read(inlineTypingOffsetProvider.notifier).state = selection.baseOffset;
  _imeStyleLogLazy(
    () =>
        'rememberIntent attr(${attribute.key}:${attribute.value}) '
        '${_selectionLog(selection)} base:${_styleLog(base)} '
        'intent:${_styleLog(intentStyle)}',
  );
}

/// 에디터 본문
class _WriteContentInput extends ConsumerStatefulWidget {
  const _WriteContentInput({required this.editorFocusNode});

  final FocusNode editorFocusNode;

  @override
  ConsumerState<_WriteContentInput> createState() => _WriteContentInputState();
}

class _WriteContentInputState extends ConsumerState<_WriteContentInput> {
  QuillController? _attachedController;
  Style _pendingInputStyle = const Style();
  int? _pendingInputOffset;
  int? _lastValidCursorOffset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _attachController(ref.read(quillControllerProvider));
    });
  }

  @override
  void dispose() {
    _detachController(resetProviderIntent: false);
    super.dispose();
  }

  void _attachController(QuillController controller) {
    if (_attachedController == controller) return;
    _detachController();
    _attachedController = controller;
    controller.onReplaceText = _onBeforeReplace;
    controller.addListener(_captureStyleIntent);
  }

  void _detachController({bool resetProviderIntent = true}) {
    _attachedController?.removeListener(_captureStyleIntent);
    if (_attachedController?.onReplaceText == _onBeforeReplace) {
      _attachedController?.onReplaceText = null;
    }
    _attachedController = null;
    _clearPendingStyleIntent(resetProviderIntent: resetProviderIntent);
  }

  void _clearPendingStyleIntent({
    String reason = '',
    bool resetProviderIntent = true,
  }) {
    if (reason.isNotEmpty) {
      _imeStyleLogLazy(
        () =>
            'clearPending reason:$reason '
            'pending:${_styleLog(_pendingInputStyle)} '
            'offset:$_pendingInputOffset',
      );
    }
    _pendingInputStyle = const Style();
    _pendingInputOffset = null;
    if (resetProviderIntent) {
      ref.read(inlineTypingStyleProvider.notifier).state = const Style();
      ref.read(inlineTypingOffsetProvider.notifier).state = null;
    }
  }

  /// 팝업/바텀시트 전환으로 toggledStyle이 사라져도
  /// 직전 스타일 적용 의도를 첫 입력까지 보존한다.
  void _captureStyleIntent() {
    final c = _attachedController;
    if (c == null) return;

    final sel = c.selection;
    if (sel.isValid && sel.baseOffset >= 0) {
      _lastValidCursorOffset = sel.baseOffset;
    }

    final toggledInline = _inlineOf(c.toggledStyle);
    _imeStyleLogLazy(
      () =>
          'capture ${_selectionLog(sel)} '
          'hasFocus:${widget.editorFocusNode.hasFocus} '
          'toggled:${_styleLog(toggledInline)} '
          'pending:${_styleLog(_pendingInputStyle)} '
          'pendingOffset:$_pendingInputOffset '
          'lastValid:$_lastValidCursorOffset',
    );
    if (toggledInline.isNotEmpty) {
      final intentOffset = (sel.isValid && sel.baseOffset >= 0)
          ? sel.baseOffset
          : _lastValidCursorOffset;
      if (intentOffset == null) return;
      _pendingInputStyle = toggledInline;
      _pendingInputOffset = intentOffset;
      _imeStyleLogLazy(
        () =>
            'capture setPending from toggled '
            'style:${_styleLog(toggledInline)} offset:$intentOffset',
      );
      return;
    }

    // 색상/폰트/사이즈 팝업 전환 중에는 selection이 invalid(-1)로 오갈 수 있으므로
    // 이 구간에서는 pending 스타일을 폐기하지 않는다.
    if (!widget.editorFocusNode.hasFocus ||
        !sel.isValid ||
        sel.baseOffset < 0) {
      _imeStyleLog('capture keepPending while focus/selection unstable');
      return;
    }

    // 한글 조합 입력 중에는 selection이 잠시 range로 바뀌므로
    // non-collapsed 상태에서 pending을 지우지 않는다.
    if (!sel.isCollapsed) {
      _imeStyleLog('capture non-collapsed; keep pending');
      return;
    }

    if (_pendingInputOffset != null) {
      if (sel.baseOffset < _pendingInputOffset!) {
        _imeStyleLogLazy(
          () =>
              'capture ignore backward sync '
              'from:${_pendingInputOffset!} to:${sel.baseOffset}',
        );
        return;
      }
      _pendingInputOffset = sel.baseOffset;
      _imeStyleLogLazy(
        () => 'capture sync pendingOffset -> $_pendingInputOffset',
      );
    }
  }

  bool _matchesPendingRange(int index, int len) {
    final p = _pendingInputOffset;
    if (p == null || _pendingInputStyle.isEmpty) return false;

    // 한글 조합 commit에서 replace 시작점이 앞쪽으로 당겨지는 경우를 허용
    final start = index - 1;
    final end = index + (len > 0 ? len : 0) + 1;
    final matched = p >= start && p <= end;
    _imeStyleLogLazy(
      () =>
          'matchPending index:$index len:$len start:$start end:$end '
          'pendingOffset:$p matched:$matched',
    );
    return matched;
  }

  /// IME/자동교정 교체 입력에서도 인라인 스타일이 끊기지 않게 보정.
  bool _onBeforeReplace(int index, int len, Object? data) {
    if (data is! String || data.isEmpty || data.contains('\n')) return true;

    final c = _attachedController;
    if (c == null) return true;

    final explicitPendingStyle = ref.read(inlineTypingStyleProvider);
    final explicitPendingOffset = ref.read(inlineTypingOffsetProvider);
    final hasExplicitPending = explicitPendingStyle.isNotEmpty;
    final explicitAnchor = explicitPendingOffset;
    final explicitTouchesRange =
        hasExplicitPending &&
        (explicitAnchor == null || (index + data.length) > explicitAnchor);
    final allowToggledInjection =
        !hasExplicitPending ||
        explicitAnchor == null ||
        index >= explicitAnchor;
    _imeStyleLogLazy(
      () =>
          'onBeforeReplace index:$index len:$len data:"$data" '
          '${_selectionLog(c.selection)} '
          'toggled:${_styleLog(_inlineOf(c.toggledStyle))} '
          'pending:${_styleLog(_pendingInputStyle)} '
          'pendingOffset:$_pendingInputOffset '
          'explicit:${_styleLog(explicitPendingStyle)} '
          'explicitOffset:$explicitPendingOffset '
          'explicitTouches:$explicitTouchesRange',
    );

    Style? forcedIntentStyle;
    if (hasExplicitPending) {
      _pendingInputStyle = explicitPendingStyle;
      if (explicitPendingOffset != null) {
        _pendingInputOffset = explicitPendingOffset;
      }

      if (explicitTouchesRange) {
        final caretInline = _inlineAtCursor(c, index);
        forcedIntentStyle = _mergeStylesPreserveNull(
          caretInline,
          explicitPendingStyle,
        );
        final forcedStyle = forcedIntentStyle;
        if (allowToggledInjection &&
            c.toggledStyle.isEmpty &&
            forcedStyle.isNotEmpty) {
          c.toggledStyle = forcedStyle;
          _imeStyleLogLazy(
            () =>
                'onBeforeReplace apply forced '
                'toggled:${_styleLog(forcedStyle)}',
          );
        } else if (!allowToggledInjection) {
          _imeStyleLogLazy(
            () =>
                'onBeforeReplace keep old style before anchor '
                'anchor:$explicitAnchor index:$index',
          );
        }

        _pendingInputOffset = index + data.length;
        _imeStyleLogLazy(
          () =>
              'onBeforeReplace explicit pendingOffset -> $_pendingInputOffset '
              'forced:${_styleLog(forcedStyle)}',
        );
      } else {
        _imeStyleLogLazy(
          () =>
              'onBeforeReplace explicit skip before anchor '
              'anchor:$explicitAnchor index:$index',
        );
      }
    }

    // 스타일 적용 직후 첫 입력에서 toggledStyle이 비어 있으면 의도 스타일 복원
    final pendingMatch =
        explicitTouchesRange ||
        (!hasExplicitPending && _matchesPendingRange(index, len));
    _imeStyleLogLazy(() => 'onBeforeReplace pendingMatch:$pendingMatch');
    if (pendingMatch) {
      final caretInline = _inlineAtCursor(c, index);
      final pendingMerged = _mergeStylesPreserveNull(
        caretInline,
        _pendingInputStyle,
      );
      if (allowToggledInjection &&
          c.toggledStyle.isEmpty &&
          pendingMerged.isNotEmpty) {
        c.toggledStyle = pendingMerged;
        _imeStyleLogLazy(
          () =>
              'onBeforeReplace restore pending '
              'toggled:${_styleLog(pendingMerged)}',
        );
      } else if (!allowToggledInjection) {
        _imeStyleLogLazy(
          () =>
              'onBeforeReplace skip pending toggled before anchor '
              'anchor:$explicitAnchor index:$index',
        );
      }
    }

    if (pendingMatch) {
      _pendingInputOffset = index + data.length;
      _imeStyleLogLazy(
        () => 'onBeforeReplace pendingOffset -> $_pendingInputOffset',
      );
    } else if (!hasExplicitPending &&
        _pendingInputOffset != null &&
        (index - _pendingInputOffset!).abs() > 8) {
      // 충분히 떨어진 위치에서 입력하면 오래된 pending 의도는 폐기
      _clearPendingStyleIntent(
        reason:
            'beforeReplace far from pending index:$index pending:$_pendingInputOffset',
      );
    }

    // 일반 단일 문자 입력은 Quill 기본 규칙이 더 안정적이므로 개입하지 않는다.
    if (len == 0 && data.length == 1) {
      _imeStyleLog('onBeforeReplace single-char fast-path');
      return true;
    }

    final inlineStyle =
        (forcedIntentStyle != null && forcedIntentStyle.isNotEmpty)
        ? forcedIntentStyle
        : _resolveInlineStyle(c, index, len);
    if (inlineStyle.isEmpty) {
      _imeStyleLog('onBeforeReplace inlineStyle empty -> pass');
      return true;
    }
    _imeStyleLogLazy(
      () => 'onBeforeReplace inlineStyle:${_styleLog(inlineStyle)}',
    );

    // 다음 입력에도 스타일이 이어지도록 현재 삽입 의도 스타일 주입
    if (allowToggledInjection && c.toggledStyle.isEmpty) {
      c.toggledStyle = inlineStyle;
      _imeStyleLog('onBeforeReplace set toggled from inlineStyle');
    } else if (!allowToggledInjection) {
      _imeStyleLogLazy(
        () =>
            'onBeforeReplace keep toggled untouched before anchor '
            'anchor:$explicitAnchor index:$index',
      );
    }

    // IME/자동교정의 교체 입력(len > 0)은 Quill 내부 스타일 유지가
    // 간헐적으로 누락될 수 있어, 삽입 직후 한 번 더 보정한다.
    if (len > 0 || data.length > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _attachedController != c) return;

        final docTextLength = c.document.length - 1; // trailing '\n' 제외
        if (docTextLength <= 0 || index >= docTextLength) return;

        final applyLen = (index + data.length <= docTextLength)
            ? data.length
            : docTextLength - index;
        if (applyLen <= 0) return;

        var formatIndex = index;
        var formatLen = applyLen;
        if (hasExplicitPending && explicitAnchor != null) {
          final shift = explicitAnchor - formatIndex;
          if (shift > 0) {
            if (shift >= formatLen) {
              _imeStyleLogLazy(
                () =>
                    'postFrame skip before anchor '
                    'anchor:$explicitAnchor index:$index applyLen:$applyLen',
              );
              return;
            }
            formatIndex = explicitAnchor;
            formatLen -= shift;
          }
        }

        final currentInline = _inlineOf(
          c.document.collectStyle(formatIndex, formatLen),
        );
        _imeStyleLogLazy(
          () =>
              'postFrame index:$formatIndex applyLen:$formatLen '
              'current:${_styleLog(currentInline)} '
              'target:${_styleLog(inlineStyle)}',
        );
        for (final attr in inlineStyle.attributes.values) {
          final current = currentInline.attributes[attr.key]?.value;
          if (current != attr.value) {
            _imeStyleLogLazy(
              () =>
                  'postFrame formatText key:${attr.key} '
                  'current:$current -> ${attr.value}',
            );
            c.formatText(formatIndex, formatLen, attr);
          }
        }
      });
    }

    return true;
  }

  static int _safeDocIndex(QuillController c, int index) {
    return index.clamp(0, c.document.length - 1);
  }

  static Style _inlineAtCursor(QuillController c, int index) {
    return _inlineOf(c.document.collectStyle(_safeDocIndex(c, index), 0));
  }

  static Style _resolveInlineStyle(QuillController c, int index, int len) {
    final caretStyle = _inlineAtCursor(c, index);
    Style base = caretStyle;
    if (len > 0) {
      final replacedIntersection = _inlineOf(
        c.document.collectStyle(index, len),
      );
      if (replacedIntersection.isNotEmpty) {
        base = replacedIntersection;
      } else {
        final replacedTail = _inlineFromRangeTail(c, index, len);
        if (replacedTail.isNotEmpty) base = replacedTail;
      }
    }

    final toggled = _inlineOf(c.toggledStyle);
    if (toggled.isNotEmpty) {
      return _mergeStylesPreserveNull(base, toggled);
    }
    if (base.isNotEmpty) return base;

    // 문서가 비어 있거나 경계 케이스에서 collectStyle이 비는 경우 fallback
    return _inlineAtCursor(c, index);
  }

  static Style _inlineFromRangeTail(QuillController c, int index, int len) {
    final start = index.clamp(0, c.document.length - 1);
    final end = (index + len - 1).clamp(0, c.document.length - 1);
    for (var i = end; i >= start; i--) {
      final s = _inlineOf(c.document.collectStyle(i, 1));
      if (s.isNotEmpty) return s;
    }
    return const Style();
  }

  static Style _mergeStylesPreserveNull(Style base, Style overlay) {
    final merged = <String, Attribute>{
      ...base.attributes,
      ...overlay.attributes,
    };
    return Style.attr(merged);
  }

  /// Style에서 인라인 속성만 추출
  static Style _inlineOf(Style style) {
    return _inlineStyleOnly(style);
  }

  @override
  Widget build(BuildContext context) {
    final quillController = ref.watch(quillControllerProvider);

    // Provider에서 controller가 변경된 경우 (드래프트 복원 등) 재연결
    if (quillController != _attachedController) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _attachController(quillController);
      });
    }

    return QuillEditor.basic(
      controller: quillController,
      focusNode: widget.editorFocusNode,
      config: QuillEditorConfig(
        placeholder: '내용을 입력해 주세요',
        minHeight: 200.h,
        customStyles: const DefaultStyles(
          paragraph: DefaultTextBlockStyle(
            TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              height: _kEditorLineHeight,
              leadingDistribution: TextLeadingDistribution.even,
              textBaseline: TextBaseline.alphabetic,
              color: DiaryMainGrey.grey900,
            ),
            HorizontalSpacing.zero,
            VerticalSpacing(6, 0),
            VerticalSpacing.zero,
            null,
          ),
        ),
        customStyleBuilder: (attribute) {
          // 폰트/사이즈/색상 등 인라인 속성이 줄 높이를 흔들지 않도록 고정
          if (Attribute.inlineKeys.contains(attribute.key)) {
            return const TextStyle(
              height: _kEditorLineHeight,
              leadingDistribution: TextLeadingDistribution.even,
              textBaseline: TextBaseline.alphabetic,
            );
          }
          return const TextStyle();
        },
        embedBuilders: [DiaryImageEmbedBuilder(), DividerEmbedBuilder()],
      ),
    );
  }
}
