import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/repository/diary_post.dart';

class DiaryViewModel {
  final repo = DiaryPostRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  Future<void> addDiaryPost(DiaryPostModel model) async {
    final value = model.copyWith(userId: userId);
    return repo.addDiaryPost(value);
  }

  Future<List<DiaryPostModel>> getDiary() async {
    return repo.getDiary();
  }
}
