part of 'write_page.dart';

class _WriteContentInput extends ConsumerStatefulWidget {
  const _WriteContentInput();

  @override
  ConsumerState<_WriteContentInput> createState() => _WriteContentInputState();
}

class _WriteContentInputState extends ConsumerState<_WriteContentInput> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(quillControllerProvider);
      controller.addListener(_updateCharCount);
    });
  }

  void _updateCharCount() {
    if (!mounted) return;
    final controller = ref.read(quillControllerProvider);
    final count = controller.document.toPlainText().trim().length;
    if (count != _charCount) {
      setState(() => _charCount = count);
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(diaryImageProvider);
    final quillController = ref.watch(quillControllerProvider);

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("내용",
              style: AppTextStyle.m3Regular
                  .copyWith(color: DiaryMainGrey.grey800)),
          const SizedBox(height: 12),

          // 툴바 (6개 버튼만)
          QuillSimpleToolbar(
            controller: quillController,
            config: const QuillSimpleToolbarConfig(
              showBoldButton: true,
              showItalicButton: true,
              showUnderLineButton: true,
              showListBullets: true,
              showListNumbers: true,
              showQuote: true,
              // 나머지 전부 숨김
              showStrikeThrough: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showAlignmentButtons: false,
              showHeaderStyle: false,
              showLink: false,
              showSearchButton: false,
              showCodeBlock: false,
              showInlineCode: false,
              showIndent: false,
              showFontFamily: false,
              showFontSize: false,
              showSubscript: false,
              showSuperscript: false,
              showSmallButton: false,
              showDirection: false,
              showDividers: false,
              showRedo: false,
              showUndo: false,
              showListCheck: false,
              showLineHeightButton: false,
            ),
          ),
          const SizedBox(height: 8),

          // 에디터 본문
          Container(
            height: 250.h,
            decoration: BoxDecoration(
              color: DiaryMainGrey.grey50,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: QuillEditor.basic(
              controller: quillController,
              config: const QuillEditorConfig(
                placeholder: '내용을 입력해 주세요',
              ),
            ),
          ),
          const SizedBox(height: 8),

          // 글자 수 카운터
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("$_charCount",
                  style: AppTextStyle.labelRegular
                      .copyWith(color: DiaryColor.globalMainColor)),
              Text("/500",
                  style: AppTextStyle.labelRegular
                      .copyWith(color: DiaryMainGrey.grey500)),
            ],
          ),

          // 이미지 선택
          GestureDetector(
            onTap: () async {
              try {
                final pickedFiles =
                    await ImagePicker().pickMultiImage(imageQuality: 50);

                if (pickedFiles.isNotEmpty) {
                  for (var file in pickedFiles) {
                    ref.read(diaryImageProvider.notifier).addImage(file);
                  }
                }
              } catch (e) {
                ref.read(diaryImageProvider.notifier).clearImages();
                if (!mounted) return;
                _scaffoldKey.currentState?.showSnackBar(
                  const SnackBar(
                    content: Text('이미지를 불러오는 중 오류가 발생했습니다.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Container(
              width: 115.w,
              height: 50.h,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: DiaryMainGrey.grey50,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("사진 추가",
                      style: AppTextStyle.m3Regular
                          .copyWith(color: DiaryMainGrey.grey600)),
                  const SizedBox(width: 8),
                  SvgPicture.asset(
                    "assets/images/icons/add-image.svg",
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // 이미지 미리보기
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...images.asMap().entries.map((entry) {
                final index = entry.key;
                final image = entry.value;

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(image.path),
                        width: 148,
                        height: 148,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(diaryImageProvider.notifier)
                              .removeImage(index);
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
