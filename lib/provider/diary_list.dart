import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

final diaryListProvider =
    FutureProvider<List<DiaryPostModel>>((ref) async {
  final viewModel = DiaryViewModel();
  return await viewModel.getDiary();
});
