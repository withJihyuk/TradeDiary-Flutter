import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPostDataSource {
  final supabase = Supabase.instance.client;

  Future createDiaryPost(json) async {
    supabase.from("diary").insert(DiaryPostModel.fromJson(json));
  }

  Future getDiaryPost(String userId) async {
    return supabase.from("diary").select().eq('userId', userId);
  }

  Future getFriendDiaryPost(String userId) async {
    final friendId =
        supabase.from("follow").select().neq('follower_id', userId);
    return supabase
        .from("diary")
        .select()
        .neq('userId', friendId)
        .eq('isPrivate', false);
  }

  Future isWriteDiaryToday(String userId) async {
    final today = DateTime.now();
    return supabase
        .from("diary")
        .select()
        .eq('userId', userId)
        .eq('createdAt', today);
  }
}
