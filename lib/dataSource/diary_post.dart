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

  Future<List> isWriteDiaryToday(String userId) {
    final nowTime = DateTime.now();

    final todayStart = nowTime.toLocal().toIso8601String().split('T')[0];
    final todayEnd = nowTime
        .add(const Duration(days: 1))
        .toLocal()
        .toIso8601String()
        .split('T')[0];
    return supabase
        .from("diary")
        .select()
        .eq('userId', userId)
        .gte('created_at', '$todayStart 00:00:00Z')
        .lt('created_at', '$todayEnd 00:00:00Z');
  }
}
