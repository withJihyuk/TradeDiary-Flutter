import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPostDataSource {
  final supabase = Supabase.instance.client;

  Future createDiaryPost(DiaryPostModel data) async {
    await supabase.from("diary").insert(data);
  }

  Future getDiaryPost(String userId) async {
    return await supabase.from("diary").select().eq('userId', userId);
  }

  Future getFriendDiaryPost(String userId) async {
    final friendId =
        await supabase.from("follow").select().neq('follower_id', userId);
    return await supabase
        .from("diary")
        .select()
        .neq('userId', friendId)
        .eq('isPrivate', false);
  }

  Future isWriteDiaryToday(String userId) async {
    final today = DateTime.now();
    return await supabase
        .from("diary")
        .select()
        .eq('userId', userId)
        .eq('createdAt', today);
  }
}
