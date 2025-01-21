part of 'write_page.dart';

class _WriteContentInput extends ConsumerWidget {
  // ignore: unused_element
  const _WriteContentInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("내용",
            style:
                AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey800)),
        const SizedBox(
          height: 12,
        ),
        InputComponents(
          hintText: "내용을 입력해 주세요",
          isLong: true,
          onChanged: (p0) {
            ref.read(diaryProvider.notifier).setContent(p0);
          },
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("${ref.watch(diaryProvider).content.length}",
                style: AppTextStyle.labelRegular
                    .copyWith(color: DiaryColor.globalMainColor)),
            Text("/500",
                style: AppTextStyle.labelRegular
                    .copyWith(color: DiaryMainGrey.grey500)),
          ],
        )
      ],
    );
  }
}
