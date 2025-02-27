part of 'diary_page.dart';

class _DiaryList extends ConsumerStatefulWidget {
  const _DiaryList();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DiaryListState();
}

class _DiaryListState extends ConsumerState<_DiaryList> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(diaryListProvider);
    final filteredDiaries = ref.watch(filteredDiaryListProvider);

    return result.when(
      skipLoadingOnRefresh: false,
      data: (_) {
        if (filteredDiaries.isEmpty) {
          return const FaildToFetchDiary();
        } else {
          return ListDiary(diaryList: filteredDiaries);
        }
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => const Center(child: Text('글을 가져오는데 실패했어요')),
    );
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

  Map<String, List<DiaryPostModel>> _groupByMonth(List<DiaryPostModel> diaries) {
    final Map<String, List<DiaryPostModel>> grouped = {};
    
    for (var diary in diaries) {
      final key = '${diary.date.year}년 ${diary.date.month}월';
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(diary);
    }
    
    // 각 월별 그룹 내에서 날짜순으로 정렬
    for (var key in grouped.keys) {
      grouped[key]!.sort((a, b) => b.date.compareTo(a.date));
    }
    
    return Map.fromEntries(
      grouped.entries.toList()
        ..sort((a, b) => b.value.first.date.compareTo(a.value.first.date))
    );
  }

  @override
  Widget build(BuildContext context) {
    final groupedDiaries = _groupByMonth(diaryList);
    
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: groupedDiaries.length,
      itemBuilder: (context, monthIndex) {
        final monthKey = groupedDiaries.keys.elementAt(monthIndex);
        final monthDiaries = groupedDiaries[monthKey]!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                monthKey,
                style: AppTextStyle.m3Regular.copyWith(
                  color: DiaryMainGrey.grey500,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: monthDiaries.length,
              itemBuilder: (context, index) {
                final diary = monthDiaries[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      DiaryHomeContentRead(
                        contentName: diary.subject,
                        contentDate: "${diary.date.month}/${diary.date.day}",
                        contentPreview: diary.content,
                        contentEmotion: diary.emotion,
                        onTap: () => PageRouter.router.push(
                          "/read/${diaryList.indexOf(diary)}", 
                          extra: diaryList
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (index < monthDiaries.length - 1)
                        const Divider(height: 1, color: DiaryMainGrey.grey50),
                    ],
                  )
                );
              },
            ),
          ],
        );
      },
    );
  }
}
