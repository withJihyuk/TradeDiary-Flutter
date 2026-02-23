import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

final diaryListProvider =
    FutureProvider.autoDispose<List<DiaryPostModel>>((ref) async {
  final viewModel = DiaryViewModel();
  return await viewModel.getDiary();
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredDiaryListProvider = Provider<List<DiaryPostModel>>((ref) {
  final diaryListAsyncValue = ref.watch(diaryListProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  return diaryListAsyncValue.when(
    data: (diaryList) {
      if (searchQuery.isEmpty) return diaryList;
      return diaryList.where((diary) {
        final subject = diary.subject.toLowerCase();
        final content = QuillContentUtil.contentToPlainText(diary.content).toLowerCase();
        return subject.contains(searchQuery) || content.contains(searchQuery);
      }).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

final todayDiaryProvider = Provider<DiaryPostModel?>((ref) {
  final diaryList = ref.watch(diaryListProvider);
  return diaryList.whenOrNull(data: (diaries) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    for (final diary in diaries) {
      final d = DateTime(diary.date.year, diary.date.month, diary.date.day);
      if (d == todayOnly) return diary;
    }
    return null;
  });
});

final diaryRefreshProvider = StateProvider<bool>((ref) => false);

final diaryListControllerProvider = Provider((ref) {
  ref.watch(diaryRefreshProvider);
  ref.invalidate(diaryListProvider);
});
