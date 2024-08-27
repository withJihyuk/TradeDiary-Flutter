import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPostDataSource {
  final supabase = Supabase.instance.client;

  Future createDiaryPost(DiaryPostModel data) async {
    await supabase.from("diary").insert(data);
  }

  Future<List> getDiaryPost(String postId) async {
    return await supabase.from("diary").select().eq('id', postId);
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

  Future<List> isWriteDiaryToday(String userId) {
    final todayStart = DateTime.now().toLocal().toIso8601String().split('T')[0];
    final todayEnd = DateTime.now()
        .add(const Duration(days: 1))
        .toLocal()
        .toIso8601String()
        .split('T')[0];
    print(todayEnd);
    print(todayStart);
    return supabase
        .from("diary")
        .select()
        .eq('userId', userId)
        .gte('created_at', '$todayStart 00:00:00Z')
        .lt('created_at', '$todayEnd 00:00:00Z');
  }
}
