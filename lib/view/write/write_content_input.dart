part of 'write_page.dart';

/// 에디터 본문만 (툴바는 _EditorToolbar로 분리됨)
class _WriteContentInput extends ConsumerStatefulWidget {
  const _WriteContentInput({required this.editorFocusNode});

  final FocusNode editorFocusNode;

  @override
  ConsumerState<_WriteContentInput> createState() => _WriteContentInputState();
}

class _WriteContentInputState extends ConsumerState<_WriteContentInput> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(quillControllerProvider);
      controller.onReplaceText = _preserveStyleOnReplace;
    });
  }

  /// iOS 자동완성이 텍스트를 교체할 때 인라인 스타일(볼드, 색상 등)을 보존
  bool _preserveStyleOnReplace(int index, int len, Object? data) {
    if (len > 0 && data is String && data.isNotEmpty && !data.contains('\n')) {
      final controller = ref.read(quillControllerProvider);
      final style = controller.document.collectStyle(index, len);
      final inlineAttrs = <String, Attribute>{};
      for (final entry in style.attributes.entries) {
        if (Attribute.inlineKeys.contains(entry.key)) {
          inlineAttrs[entry.key] = entry.value;
        }
      }
      if (inlineAttrs.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          for (final attr in inlineAttrs.values) {
            controller.formatText(index, data.length, attr);
          }
        });
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final quillController = ref.watch(quillControllerProvider);

    return QuillEditor.basic(
      controller: quillController,
      focusNode: widget.editorFocusNode,
      config: QuillEditorConfig(
        placeholder: '내용을 입력해 주세요',
        minHeight: 200.h,
        customStyles: const DefaultStyles(
          paragraph: DefaultTextBlockStyle(
            TextStyle(
              fontSize: 16,
              height: 1.8,
              color: DiaryMainGrey.grey900,
            ),
            HorizontalSpacing.zero,
            VerticalSpacing(6, 0),
            VerticalSpacing.zero,
            null,
          ),
        ),
        embedBuilders: [DiaryImageEmbedBuilder()],
      ),
    );
  }
}

/// 키보드 위에 고정되는 에디터 툴바
class _EditorToolbar extends ConsumerWidget {
  const _EditorToolbar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quillController = ref.watch(quillControllerProvider);
    final enabledFonts = ref.watch(fontProvider);

    return Container(
      decoration: const BoxDecoration(
        color: DiaryMainGrey.grey50,
        border: Border(
          top: BorderSide(color: DiaryMainGrey.grey200, width: 0.5),
        ),
      ),
      child: QuillSimpleToolbar(
        controller: quillController,
        config: QuillSimpleToolbarConfig(
          multiRowsDisplay: false,
          showDividers: true,
          sectionDividerColor: DiaryMainGrey.grey200,
          sectionDividerSpace: 2,
          dialogTheme: QuillDialogTheme(
            dialogBackgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            labelTextStyle: AppTextStyle.labelRegular
                .copyWith(color: DiaryMainGrey.grey600),
            inputTextStyle:
                AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey900),
            buttonTextStyle:
                AppTextStyle.m3Semi.copyWith(color: DiaryColor.globalMainColor),
            buttonStyle: TextButton.styleFrom(
              foregroundColor: DiaryColor.globalMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          iconTheme: const QuillIconTheme(
            iconButtonSelectedData: IconButtonData(
              color: DiaryColor.globalMainColor,
            ),
            iconButtonUnselectedData: IconButtonData(
              color: DiaryMainGrey.grey700,
            ),
          ),
          buttonOptions: QuillSimpleToolbarButtonOptions(
            fontFamily: QuillToolbarFontFamilyButtonOptions(
              items: enabledFonts.isNotEmpty
                  ? enabledFonts
                  : const {'프리텐다드': 'Pretendard'},
              defaultDisplayText: '프리텐다드',
            ),
            fontSize: const QuillToolbarFontSizeButtonOptions(
              items: {
                '12': '12',
                '14': '14',
                '16': '16',
                '18': '18',
                '20': '20',
                '24': '24',
              },
              defaultDisplayText: '16',
            ),
            color: QuillToolbarColorButtonOptions(
              customOnPressedCallback: (controller, isBackground) async {
                await _showColorPicker(context, ref, controller, isBackground);
              },
            ),
          ),
          embedButtons: const [imageEmbedButton],
          customButtons: [
            // 링크 삽입 버튼 (바텀시트)
            QuillToolbarCustomButtonOptions(
              icon: const Icon(Icons.link, size: 20),
              tooltip: '링크 삽입',
              onPressed: () => _showLinkSheet(context, ref),
            ),
          ],
          showFontFamily: enabledFonts.length > 1,
          showFontSize: true,
          showBoldButton: true,
          showItalicButton: true,
          showUnderLineButton: true,
          showStrikeThrough: true,
          showColorButton: true,
          showLink: false,
          showClearFormat: true,
          showHeaderStyle: true,
          showUndo: true,
          showRedo: true,
          showBackgroundColorButton: false,
          showAlignmentButtons: false,
          showListBullets: false,
          showListNumbers: false,
          showQuote: false,
          showIndent: false,
          showCodeBlock: false,
          showInlineCode: false,
          showSearchButton: false,
          showSubscript: false,
          showSuperscript: false,
          showSmallButton: false,
          showDirection: false,
          showListCheck: false,
          showLineHeightButton: false,
        ),
      ),
    );
  }

  /// 링크 삽입 바텀시트
  static void _showLinkSheet(BuildContext context, WidgetRef ref) {
    final controller = ref.read(quillControllerProvider);
    final initial = QuillTextLink.prepare(controller);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _LinkSheet(
        initialText: initial.text,
        initialLink: initial.link,
        onSubmit: (text, link) {
          if (text.isNotEmpty && link.isNotEmpty) {
            QuillTextLink(text, link).submit(controller);
          }
        },
      ),
    );
  }

  /// 커스텀 색상 피커 (자주 쓰는 색 + 최근 사용 색)
  static Future<void> _showColorPicker(
    BuildContext context,
    WidgetRef ref,
    QuillController controller,
    bool isBackground,
  ) async {
    final recentColors = ref.read(recentColorsProvider);

    final Color? picked = await showModalBottomSheet<Color>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _ColorPickerSheet(
        recentColors: recentColors,
        isBackground: isBackground,
      ),
    );

    if (picked == null) return;

    // 최근 사용 색에 추가
    ref.read(recentColorsProvider.notifier).add(picked);

    // 색상 적용
    final hex =
        '#${picked.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
    if (isBackground) {
      controller.formatSelection(BackgroundAttribute(hex));
    } else {
      controller.formatSelection(ColorAttribute(hex));
    }
  }
}

/// 자주 쓰는 색상 목록
const _frequentColors = [
  Colors.black,
  Color(0xFF333333),
  Color(0xFF666666),
  Color(0xFF999999),
  Colors.red,
  Color(0xFFE53935),
  Color(0xFFFF7043),
  Colors.orange,
  Color(0xFFFFC107),
  Colors.green,
  Color(0xFF43A047),
  Color(0xFF26A69A),
  Colors.blue,
  Color(0xFF1E88E5),
  Color(0xFF5C6BC0),
  Colors.purple,
  Color(0xFFAB47BC),
  Color(0xFFEC407A),
  Color(0xFFD8A980), // globalMainColor
  Colors.brown,
];

/// 최근 사용 색상 Provider
class RecentColorsNotifier extends StateNotifier<List<Color>> {
  RecentColorsNotifier() : super([]);

  void add(Color color) {
    final updated = [
      color,
      ...state.where((c) => c.toARGB32() != color.toARGB32())
    ];
    state = updated.take(10).toList();
  }
}

final recentColorsProvider =
    StateNotifierProvider<RecentColorsNotifier, List<Color>>((ref) {
  return RecentColorsNotifier();
});

/// 색상 피커 바텀시트
class _ColorPickerSheet extends StatelessWidget {
  const _ColorPickerSheet({
    required this.recentColors,
    required this.isBackground,
  });

  final List<Color> recentColors;
  final bool isBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isBackground ? '배경 색상' : '글자 색상',
            style: AppTextStyle.m2Semi,
          ),
          if (recentColors.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              '최근 사용한 색',
              style: AppTextStyle.labelRegular
                  .copyWith(color: DiaryMainGrey.grey500),
            ),
            const SizedBox(height: 8),
            _ColorGrid(
              colors: recentColors,
              onSelect: (c) => Navigator.of(context).pop(c),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            '자주 쓰는 색',
            style: AppTextStyle.labelRegular
                .copyWith(color: DiaryMainGrey.grey500),
          ),
          const SizedBox(height: 8),
          _ColorGrid(
            colors: _frequentColors,
            onSelect: (c) => Navigator.of(context).pop(c),
          ),
          const SizedBox(height: 12),
          // 검은색 초기화 버튼
          Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(Colors.black),
              child: Text(
                '기본 색상으로',
                style: AppTextStyle.labelRegular
                    .copyWith(color: DiaryMainGrey.grey700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  const _ColorGrid({required this.colors, required this.onSelect});
  final List<Color> colors;
  final ValueChanged<Color> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors
          .map((c) => GestureDetector(
                onTap: () => onSelect(c),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: c.computeLuminance() > 0.9
                          ? DiaryMainGrey.grey300
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}

/// 링크 삽입 바텀시트
class _LinkSheet extends StatefulWidget {
  const _LinkSheet({
    required this.initialText,
    required this.initialLink,
    required this.onSubmit,
  });

  final String initialText;
  final String? initialLink;
  final void Function(String text, String link) onSubmit;

  @override
  State<_LinkSheet> createState() => _LinkSheetState();
}

class _LinkSheetState extends State<_LinkSheet> {
  late final TextEditingController _textController;
  late final TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
    _linkController = TextEditingController(text: widget.initialLink ?? '');
  }

  @override
  void dispose() {
    _textController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('링크 삽입', style: AppTextStyle.m2Semi),
          const SizedBox(height: 16),
          Text(
            '표시 텍스트',
            style: AppTextStyle.labelRegular
                .copyWith(color: DiaryMainGrey.grey500),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _textController,
            style:
                AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey900),
            decoration: InputDecoration(
              hintText: '링크에 표시될 텍스트',
              hintStyle:
                  AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey400),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: DiaryMainGrey.grey200, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: DiaryMainGrey.grey200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: DiaryColor.globalMainColor, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'URL',
            style: AppTextStyle.labelRegular
                .copyWith(color: DiaryMainGrey.grey500),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _linkController,
            keyboardType: TextInputType.url,
            autocorrect: false,
            style:
                AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey900),
            decoration: InputDecoration(
              hintText: 'https://',
              hintStyle:
                  AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey400),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: DiaryMainGrey.grey200, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: DiaryMainGrey.grey200, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: DiaryColor.globalMainColor, width: 1),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                widget.onSubmit(
                  _textController.text.trim(),
                  _linkController.text.trim(),
                );
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: DiaryColor.globalMainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('확인', style: AppTextStyle.m3Semi),
            ),
          ),
        ],
      ),
    );
  }
}

