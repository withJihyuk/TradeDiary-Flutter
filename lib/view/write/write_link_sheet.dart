part of 'write_page.dart';

// ─── 링크 삽입 바텀시트 ───

void _showLinkSheet(BuildContext context, WidgetRef ref) {
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

// ─── 링크 삽입 바텀시트 ───

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
            style: AppTextStyle.labelRegular.copyWith(
              color: DiaryMainGrey.grey500,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _textController,
            style: AppTextStyle.m3Regular.copyWith(
              color: DiaryMainGrey.grey900,
            ),
            decoration: InputDecoration(
              hintText: '링크에 표시될 텍스트',
              hintStyle: AppTextStyle.m3Regular.copyWith(
                color: DiaryMainGrey.grey400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: DiaryMainGrey.grey200,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: DiaryMainGrey.grey200,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: DiaryColor.globalMainColor,
                  width: 1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'URL',
            style: AppTextStyle.labelRegular.copyWith(
              color: DiaryMainGrey.grey500,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _linkController,
            keyboardType: TextInputType.url,
            autocorrect: false,
            style: AppTextStyle.m3Regular.copyWith(
              color: DiaryMainGrey.grey900,
            ),
            decoration: InputDecoration(
              hintText: 'https://',
              hintStyle: AppTextStyle.m3Regular.copyWith(
                color: DiaryMainGrey.grey400,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: DiaryMainGrey.grey200,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: DiaryMainGrey.grey200,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: DiaryColor.globalMainColor,
                  width: 1,
                ),
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
