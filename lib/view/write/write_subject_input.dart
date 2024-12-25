part of 'write_page.dart';

class _WriteSubjectInput extends ConsumerWidget {
  // ignore: unused_element
  const _WriteSubjectInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("제목",
            style:
                AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey800)),
        const SizedBox(
          height: 12,
        ),
        InputComponents(
          hintText: "제목을 입력해주세요",
          isLong: false,
          onChanged: (p0) => ref.read(diaryProvider.notifier).setSubject(p0),
        ),
      ],
    );
  }
}
