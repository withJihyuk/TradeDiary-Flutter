
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/repository/diary_post.dart';

class DiaryPostViewModel {
  final repo = DiaryPostRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  Future<void> addDiaryPost(String content, bool isPrivate, String subject,
      String emotion, List<String> image, DateTime date) async {
    final DiaryPostModel model = DiaryPostModel(
      subject: subject,
      content: content,
      date: date,
      emotion: emotion,
      image: image,
      isPrivate: isPrivate,
    );
    return repo.addDiaryPost(model);
  }

  String getTodayDate() {
    final now = DateTime.now();
    return "${now.month}월 ${now.day}일";
  }
}
