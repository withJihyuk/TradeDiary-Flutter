import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPost {
  final supabase = Supabase.instance.client;

  Future createDiaryPost(json) async {
    supabase.from("diary").insert(DiaryPostModel.fromJson(json));
  }

  Future getDiaryPost(String userId) async {
    return supabase.from("diary").select().eq('id', userId);
  }

  Future getFriendDiaryPost(String userId) async {
    final friendId =
        supabase.from("follow").select().neq('follower_id', userId);
    return supabase
        .from("diary")
        .select()
        .neq('id', friendId)
        .eq('isPrivate', false);
  }
}
