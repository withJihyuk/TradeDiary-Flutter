part of 'write_page.dart';

class _WriteSubjectInput extends ConsumerWidget {
  const _WriteSubjectInput({
    required this.editorFocusNode,
    required this.controller,
  });

  final FocusNode editorFocusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onChanged: (p0) => ref.read(diaryProvider.notifier).setSubject(p0),
      textInputAction: TextInputAction.next,
      onSubmitted: (_) => editorFocusNode.requestFocus(),
      maxLength: 30,
      style: AppTextStyle.h4Semi.copyWith(color: DiaryMainGrey.grey900),
      decoration: InputDecoration(
        counterText: "",
        hintText: "제목을 입력하세요",
        hintStyle: AppTextStyle.h4Semi.copyWith(color: DiaryMainGrey.grey400),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
