import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/repository/diary_post.dart';

class HomeViewModel {
  final repo = DiaryPostRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  Future isUserWriteDiaryToday() async {
    final result = await repo.isUserWriteDiaryToday(userId);
    final diaryId = result.isEmpty ? false : result[0];
    return diaryId;
  }
}
