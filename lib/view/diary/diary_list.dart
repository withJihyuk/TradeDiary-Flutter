part of 'diary_page.dart';

class _DiaryList extends ConsumerWidget {
  // ignore: unused_element
  const _DiaryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(diaryListNotifier);
    ref.read(diaryListNotifier.notifier).getDiaryList();

    if (result.isEmpty) {
      return const FaildToFetchDiary();
    } else {
      return ListDiary(diaryList: result);
    }
  }
}

class FaildToFetchDiary extends StatelessWidget {
  const FaildToFetchDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/images/character/img-potato-sad.png'),
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        Text(
          "아직 일기가 없어요",
          style:
              AppTextStyle.h4Semi.copyWith(color: DiaryColor.globalMainColor),
        ),
        Text(
          "하단의 버튼을 눌러 일기를 작성해 보세요!",
          style: AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey800),
        ),
      ],
    );
  }
}

class ListDiary extends StatelessWidget {
  const ListDiary({super.key, required this.diaryList});
  final List<DiaryPostModel> diaryList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: diaryList.length,
      itemBuilder: (context, index) {
        final diary = diaryList[index];
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                DiaryHomeContentRead(
                  contentName: diary.subject,
                  contentDate: "${diary.date.month}/${diary.date.day}",
                  contentPreview: diary.content,
                  contentEmotion: diary.emotion,
                  onTap: () =>
                      PageRouter.router.push("/read/$index", extra: diaryList),
                ),
                const SizedBox(height: 24),
                if (index < diaryList.length - 1)
                  const Divider(height: 1, color: DiaryMainGrey.grey50),
              ],
            ));
      },
    );
  }
}
