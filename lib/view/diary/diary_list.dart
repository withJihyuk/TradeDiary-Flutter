part of 'diary_page.dart';

class _DiaryList extends ConsumerWidget {
  const _DiaryList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paginatedDiaryProvider);
    final notifier = ref.read(paginatedDiaryProvider.notifier);
    if (state.isLoading && state.items.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              if (state.error != null && state.items.isEmpty)
                TextButton(
                  onPressed: notifier.loadInitial,
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
            ],
          ),
        ),
        SliverList.builder(
          itemCount: state.items.length,
          itemBuilder: (context, i) {
            final diary = state.items[i];
            final date = diaryDateOnly(diary);
            final prev = i == 0 ? null : diaryDateOnly(state.items[i - 1]);
            return Column(
              children: [
                if (prev == null ||
                    date.month != prev.month ||
                    date.year != prev.year)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        '${date.year}년 ${date.month}월',
                        style: AppTextStyle.m3Semi.copyWith(
                          color: DiaryMainGrey.grey600,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: DiaryHomeContentRead(
                    contentName: diary.subject.isEmpty
                        ? '제목 없음'
                        : diary.subject,
                    contentDate: '${date.month}/${date.day}',
                    contentPreview: QuillContentUtil.contentToPlainText(
                      diary.content,
                    ),
                    contentEmotion: diary.emotion,
                    onTap: () => PageRouter.router.push(
                      '/read/${diary.id}',
                      extra: diary,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        if (state.items.isNotEmpty && (state.hasMore || state.error != null))
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: state.isLoading
                  ? null
                  : state.error != null && !state.hasMore
                  ? notifier.loadInitial
                  : notifier.loadMore,
              child: Text(
                state.isLoading
                    ? '불러오는 중…'
                    : state.error != null
                    ? '글을 가져오지 못했어요 · 재시도'
                    : '더 보기',
              ),
            ),
          ),
      ],
    );
  }
}
