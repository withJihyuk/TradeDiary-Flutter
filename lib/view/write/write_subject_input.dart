part of 'write_page.dart';

class _WriteSubjectInput extends StatelessWidget {
  // ignore: unused_element
  const _WriteSubjectInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("제목",
            style:
                AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey800)),
        const SizedBox(
          height: 12,
        ),
        const InputComponents(
          hintText: "제목을 입력해주세요",
          isLong: false,
        ),
      ],
    );
  }
}
