import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/user_follow.dart';

class Profile {
  final supabase = Supabase.instance.client;

  Future changeUserProfileImage(String clientId, String imageUrl) async {
    await supabase.from("profile").update({'profile_url' : imageUrl}).eq("id", clientId);
  }

  Future getUserProfile(String clientId) async {
    await supabase.from("profile").select().eq("id", clientId);
  }

  Future searchUserByNickname(String nickname) async {
    await supabase.from("profile").select().eq("nickname", nickname);
  }

  Future getUserFollow(String clientId) async {
    await supabase.from("follow").select().eq("fromUser", clientId);
  }

  Future followAnotherUser(UserFollowModel data) async {
    await supabase.from("follow").insert(data);
  }

  Future unFollowAnotherUser(String fromClientId, String toClientId) async {
    await supabase
        .from("follow")
        .delete()
        .eq("fromuser", fromClientId)
        .eq("toUser", toClientId);
  }
}
