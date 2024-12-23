part of 'write_page.dart';

class _WriteContentInput extends StatelessWidget {
  // ignore: unused_element
  const _WriteContentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("내용",
            style:
                AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey800)),
        const SizedBox(
          height: 12,
        ),
        const InputComponents(
          hintText: "내용을 입력해 주세요",
          isLong: true,
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("마크다운 형식을 지원해요",
                style: AppTextStyle.labelRegular
                    .copyWith(color: DiaryMainGrey.grey400)),
            Text("0/500",
                style: AppTextStyle.labelRegular
                    .copyWith(color: DiaryMainGrey.grey500)),
          ],
        )
      ],
    );
  }
}
