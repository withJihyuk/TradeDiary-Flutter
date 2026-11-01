part of 'write_page.dart';

// ─── 링크 삽입 바텀시트 ───

void _showLinkSheet(BuildContext context, WidgetRef ref) {
  final controller = ref.read(quillControllerProvider);
  final initial = QuillTextLink.prepare(controller);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
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

InputDecoration _inputDecoration(String hint, {String? errorText}) {
  OutlineInputBorder border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color, width: 1),
  );
  return InputDecoration(
    hintText: hint,
    errorText: errorText,
    hintStyle: AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey400),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: border(DiaryMainGrey.grey200),
    enabledBorder: border(DiaryMainGrey.grey200),
    focusedBorder: border(DiaryColor.globalMainColor),
  );
}

String? _normalizeLink(String input) {
  if (input.isEmpty) return input;
  final value = input.contains('://') ? input : 'https://$input';
  final uri = Uri.tryParse(value);
  if (uri == null ||
      !(uri.scheme == 'http' || uri.scheme == 'https') ||
      uri.host.isEmpty) {
    return null;
  }
  return value;
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
  String? _linkError;

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
            decoration: _inputDecoration('링크에 표시될 텍스트'),
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
            decoration: _inputDecoration('https://', errorText: _linkError),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                final link = _normalizeLink(_linkController.text.trim());
                if (link == null) {
                  setState(() => _linkError = '올바른 주소를 입력해 주세요');
                  return;
                }
                widget.onSubmit(_textController.text.trim(), link);
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
