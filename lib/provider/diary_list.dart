import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

class DiaryListNotifier extends StateNotifier<List<DiaryPostModel>> {
  DiaryListNotifier() : super([]);
  final viewModel = DiaryViewModel();

  Future<void> getDiaryList() async {
    state = await viewModel.getDiary();
  }
}

final diaryListNotifier =
    StateNotifierProvider<DiaryListNotifier, List<DiaryPostModel>>((ref) {
  return DiaryListNotifier();
});
