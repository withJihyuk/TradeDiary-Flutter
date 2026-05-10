part of 'diary_page.dart';

class _DiaryList extends ConsumerWidget {
  const _DiaryList();

  Future<void> _deleteDraft(
      BuildContext context, WidgetRef ref, String id) async {
    try {
      await DiaryPostDataSource().deleteDraft(id);
      ref.invalidate(diaryListProvider);
      ref.read(paginatedDiaryProvider.notifier).refresh();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryState = ref.watch(paginatedDiaryProvider);

    if (diaryState.error != null && diaryState.items.isEmpty) {
      return const Center(child: Text('글을 가져오는데 실패했어요'));
    }
    if (diaryState.isLoading && diaryState.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (diaryState.items.isEmpty) {
      return const FaildToFetchDiary();
    }

    return ListDiary(
      diaryList: diaryState.items,
      isLoadingMore: diaryState.isLoading && diaryState.items.isNotEmpty,
      hasMore: diaryState.hasMore,
      onDeleteDraft: (id) => _deleteDraft(context, ref, id),
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
  const ListDiary({
    super.key,
    required this.diaryList,
    required this.onDeleteDraft,
    this.isLoadingMore = false,
    this.hasMore = true,
  });
  final List<DiaryPostModel> diaryList;
  final bool isLoadingMore;
  final bool hasMore;
  final Future<void> Function(String id) onDeleteDraft;

  Map<String, List<DiaryPostModel>> _groupByMonth(
      List<DiaryPostModel> diaries) {
    final Map<String, List<DiaryPostModel>> grouped = {};

    for (var diary in diaries) {
      final diaryDate = diaryEffectiveDateTime(diary);
      final key = '${diaryDate.year}년 ${diaryDate.month}월';
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(diary);
    }

    // 각 월별 그룹 내에서 날짜순으로 정렬
    for (var key in grouped.keys) {
      grouped[key]!.sort((a, b) =>
          diaryEffectiveDateTime(b).compareTo(diaryEffectiveDateTime(a)));
    }

    return Map.fromEntries(grouped.entries.toList()
      ..sort((a, b) => diaryEffectiveDateTime(b.value.first)
          .compareTo(diaryEffectiveDateTime(a.value.first))));
  }

  Future<void> _showDraftContextMenu(
      BuildContext context, DiaryPostModel diary, Offset globalPosition) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final local = overlay.globalToLocal(globalPosition);

    final menuOffset = RelativeRect.fromLTRB(
      local.dx,
      local.dy,
      overlay.size.width - local.dx,
      overlay.size.height - local.dy,
    );

    final value = await showMenu<String>(
      context: context,
      position: menuOffset,
      elevation: 12,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit_outlined,
                  size: 18, color: DiaryMainGrey.grey700),
              const SizedBox(width: 10),
              Text('이어쓰기',
                  style: AppTextStyle.m3Regular
                      .copyWith(color: DiaryMainGrey.grey900)),
            ],
          ),
        ),
        const PopupMenuDivider(height: 0.5),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete_outline, size: 18, color: Colors.red),
              const SizedBox(width: 10),
              Text('삭제',
                  style: AppTextStyle.m3Regular.copyWith(color: Colors.red)),
            ],
          ),
        ),
      ],
    );

    if (value == 'edit') {
      PageRouter.router.push("/write", extra: diary.id);
    } else if (value == 'delete' && diary.id != null) {
      await onDeleteDraft(diary.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedDiaries = _groupByMonth(diaryList);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
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
                    final diaryDate = diaryEffectiveDateTime(diary);
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            DiaryHomeContentRead(
                              contentName: diary.subject.isEmpty
                                  ? '제목 없음'
                                  : diary.subject,
                              contentDate:
                                  "${diaryDate.month}/${diaryDate.day}",
                              contentPreview:
                                  QuillContentUtil.contentToPlainText(
                                      diary.content),
                              contentEmotion: diary.emotion,
                              isDraft: diary.isDraft,
                              onLongPressStart: diary.isDraft
                                  ? (details) => _showDraftContextMenu(
                                      context, diary, details.globalPosition)
                                  : null,
                              onTap: () {
                                if (diary.isDraft) {
                                  PageRouter.router
                                      .push("/write", extra: diary.id);
                                } else {
                                  final nonDraftList = diaryList
                                      .where((d) => !d.isDraft)
                                      .toList();
                                  PageRouter.router.push(
                                    "/read/${nonDraftList.indexOf(diary)}",
                                    extra: nonDraftList,
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            if (index < monthDiaries.length - 1)
                              const Divider(
                                  height: 1, color: DiaryMainGrey.grey50),
                          ],
                        ));
                  },
                ),
              ],
            );
          },
        ),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
