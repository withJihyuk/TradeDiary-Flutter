import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/repository/diary_post.dart';

class DiaryPostViewModel {
  final repo = DiaryPostRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  Future getDiaryPost() async {
    return repo.getDiaryPost(userId);
  }

  Future getFriendDiaryPost() async {
    return repo.getFriendDiaryPost(userId);
  }

  Future isUserWriteDiaryToday() async {
    return repo.isUserWriteDiaryToday(userId);
  }

  Future<void> addDiaryPost(String content, bool isPrivate) async {
    final DiaryPostModel model = DiaryPostModel(
      userId: userId,
      content: content,
      isPrivate: isPrivate,
    );
    return repo.addDiaryPost(model);
  }
}
