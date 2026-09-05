part of 'write_page.dart';

// ─── 텍스트 패널 ───

class _TextPanel extends ConsumerStatefulWidget {
  const _TextPanel();

  @override
  ConsumerState<_TextPanel> createState() => _TextPanelState();
}

class _TextPanelState extends ConsumerState<_TextPanel> {
  QuillController? _controller;

  void _onControllerChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(quillControllerProvider);
    final enabledFonts = ref.watch(fontProvider);
    final safeSelectionStart = controller.selection.start.clamp(
      0,
      controller.document.length - 1,
    );

    void applyInline(Attribute attr) {
      controller.formatSelection(attr);
      _rememberInlineIntent(ref, controller, attr);
    }

    // 컨트롤러가 바뀌면 리스너 재등록
    if (_controller != controller) {
      _controller?.removeListener(_onControllerChanged);
      _controller = controller;
      controller.addListener(_onControllerChanged);
    }

    // 토글 상태 (bold 등)는 선택 범위 교집합 사용
    final style = controller.getSelectionStyle();
    final isBold = style.containsKey(Attribute.bold.key);
    final isItalic = style.containsKey(Attribute.italic.key);
    final isUnderline = style.containsKey(Attribute.underline.key);
    final isStrike = style.containsKey(Attribute.strikeThrough.key);

    // 색상/폰트/사이즈는 커서 위치 기준 (범위 선택 시 교집합이 빈 값 반환하는 문제 방지)
    final posStyle = controller.document.collectStyle(safeSelectionStart, 0);
    final mergedStyle = posStyle.mergeAll(controller.toggledStyle);

    // 현재 텍스트 색상
    final currentColor =
        _parseHexColor(mergedStyle.attributes[Attribute.color.key]?.value) ??
        Colors.black;

    // 현재 배경 색상
    final currentBgColor = _parseHexColor(
      mergedStyle.attributes[Attribute.background.key]?.value,
    );

    // 현재 폰트
    final currentFont =
        mergedStyle.attributes[Attribute.font.key]?.value as String? ??
        'Pretendard';
    final currentFontDisplay =
        enabledFonts.entries
            .where((e) => e.value == currentFont)
            .firstOrNull
            ?.key ??
        '프리텐다드';

    // 현재 사이즈
    final currentSize =
        mergedStyle.attributes[Attribute.size.key]?.value?.toString() ?? '16';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: const BoxDecoration(
        color: DiaryMainGrey.grey50,
        border: Border(
          top: BorderSide(color: DiaryMainGrey.grey200, width: 0.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // 텍스트 색상 (원)
            GestureDetector(
              onTap: () => _showColorPicker(context, ref, controller, false),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: currentColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: currentColor.computeLuminance() > 0.9
                        ? DiaryMainGrey.grey300
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 배경 색상
            GestureDetector(
              onTap: () => _showColorPicker(context, ref, controller, true),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: currentBgColor ?? DiaryMainGrey.grey100,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: DiaryMainGrey.grey300, width: 1),
                ),
                child: currentBgColor == null
                    ? const Icon(
                        Icons.format_color_fill_outlined,
                        size: 14,
                        color: DiaryMainGrey.grey500,
                      )
                    : null,
              ),
            ),
            const _TextPanelDivider(),
            // 폰트
            _TextDropdown(
              value: currentFontDisplay,
              items: enabledFonts.keys.toList(),
              onSelected: (display) {
                final fontFamily = enabledFonts[display];
                if (fontFamily != null) {
                  final attr = Attribute.fromKeyValue(
                    'font',
                    fontFamily == 'Pretendard' ? null : fontFamily,
                  );
                  if (attr != null) {
                    applyInline(attr);
                  }
                }
              },
            ),
            const SizedBox(width: 8),
            // 사이즈
            _TextDropdown(
              value: currentSize,
              items: const ['12', '14', '16', '18', '20', '24', '28'],
              onSelected: (size) {
                final attr = Attribute.fromKeyValue(
                  'size',
                  size == '16' ? null : size,
                );
                if (attr != null) {
                  applyInline(attr);
                }
              },
            ),
            const _TextPanelDivider(),
            // Bold
            _TextToggle(
              isActive: isBold,
              onTap: () {
                final attr = isBold
                    ? Attribute.clone(Attribute.bold, null)
                    : Attribute.bold;
                applyInline(attr);
              },
              child: Text(
                'B',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isBold
                      ? DiaryColor.globalMainColor
                      : DiaryMainGrey.grey700,
                ),
              ),
            ),
            // Italic
            _TextToggle(
              isActive: isItalic,
              onTap: () {
                final attr = isItalic
                    ? Attribute.clone(Attribute.italic, null)
                    : Attribute.italic;
                applyInline(attr);
              },
              child: Text(
                'I',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: isItalic
                      ? DiaryColor.globalMainColor
                      : DiaryMainGrey.grey700,
                ),
              ),
            ),
            // Underline
            _TextToggle(
              isActive: isUnderline,
              onTap: () {
                final attr = isUnderline
                    ? Attribute.clone(Attribute.underline, null)
                    : Attribute.underline;
                applyInline(attr);
              },
              child: Text(
                'U',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  color: isUnderline
                      ? DiaryColor.globalMainColor
                      : DiaryMainGrey.grey700,
                ),
              ),
            ),
            // Strikethrough
            _TextToggle(
              isActive: isStrike,
              onTap: () {
                final attr = isStrike
                    ? Attribute.clone(Attribute.strikeThrough, null)
                    : Attribute.strikeThrough;
                applyInline(attr);
              },
              child: Text(
                'S',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  color: isStrike
                      ? DiaryColor.globalMainColor
                      : DiaryMainGrey.grey700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextPanelDivider extends StatelessWidget {
  const _TextPanelDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(width: 1, height: 20, color: DiaryMainGrey.grey200),
    );
  }
}

class _TextDropdown extends StatelessWidget {
  const _TextDropdown({
    required this.value,
    required this.items,
    required this.onSelected,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      offset: const Offset(0, -40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      itemBuilder: (_) => items
          .map(
            (item) => PopupMenuItem(
              value: item,
              child: Text(
                item,
                style: AppTextStyle.labelRegular.copyWith(
                  color: item == value
                      ? DiaryColor.globalMainColor
                      : DiaryMainGrey.grey900,
                ),
              ),
            ),
          )
          .toList(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTextStyle.labelRegular.copyWith(
              color: DiaryMainGrey.grey700,
            ),
          ),
          const Icon(
            Icons.arrow_drop_down,
            size: 16,
            color: DiaryMainGrey.grey500,
          ),
        ],
      ),
    );
  }
}

class _TextToggle extends StatelessWidget {
  const _TextToggle({
    required this.isActive,
    required this.onTap,
    required this.child,
  });

  final Widget child;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? DiaryColor.globalMainColor.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: child,
      ),
    );
  }
}
