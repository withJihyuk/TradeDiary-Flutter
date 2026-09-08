part of 'diary_page.dart';

class _DiaryList extends ConsumerWidget {
  const _DiaryList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paginatedDiaryProvider);
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        if (state.error != null)
          TextButton(
            onPressed: () => state.items.isEmpty
                ? ref.read(paginatedDiaryProvider.notifier).loadInitial()
                : ref.read(paginatedDiaryProvider.notifier).loadMore(),
            child: const Text('글을 가져오지 못했어요 · 재시도'),
          ),
        if (state.items.isEmpty && state.error == null)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              state.query.isEmpty
                  ? '아직 일기가 없어요. 아래 버튼으로 작성해 보세요'
                  : '검색 결과가 없어요. 다른 검색어를 입력해 주세요',
            ),
          ),
        for (var i = 0; i < state.items.length; i++) ...[
          if (i == 0 ||
              diaryDateOnly(state.items[i]).month !=
                  diaryDateOnly(state.items[i - 1]).month ||
              diaryDateOnly(state.items[i]).year !=
                  diaryDateOnly(state.items[i - 1]).year)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  '${diaryDateOnly(state.items[i]).year}년 ${diaryDateOnly(state.items[i]).month}월',
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: DiaryHomeContentRead(
              contentName: state.items[i].subject.isEmpty
                  ? '제목 없음'
                  : state.items[i].subject,
              contentDate:
                  '${diaryDateOnly(state.items[i]).month}/${diaryDateOnly(state.items[i]).day}',
              contentPreview: QuillContentUtil.contentToPlainText(
                state.items[i].content,
              ),
              contentEmotion: state.items[i].emotion,
              onTap: () => PageRouter.router.push(
                '/read/${state.items[i].id}',
                extra: state.items[i],
              ),
            ),
          ),
        ],
        if (state.items.isNotEmpty && state.hasMore)
          TextButton(
            onPressed: state.isLoading
                ? null
                : ref.read(paginatedDiaryProvider.notifier).loadMore,
            child: Text(state.isLoading ? '불러오는 중…' : '더 보기'),
          ),
      ],
    );
  }
}
