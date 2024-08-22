import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPost {
  final supabase = Supabase.instance.client;

  Future createDiaryPost(json) async {
    supabase.from("diary").insert(DiaryPostModel.fromJson(json));
  }

  Future getDiaryPost() async {
    final id = supabase.auth.currentUser!.id;
    return supabase.from("diary").select().eq('id', id);
  }

  Future getFriendDiaryPost() async {
    final id = supabase.auth.currentUser!.id;
    final friendId = supabase.from("follow").select().neq('follower_id', id);
    return supabase
        .from("diary")
        .select()
        .neq('id', friendId)
        .eq('isPrivate', false);
  }
}
