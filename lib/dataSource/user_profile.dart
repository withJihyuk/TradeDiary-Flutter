import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/user_follow.dart';
import 'package:trade_diary/model/user_profile.dart';

class Profile {
  final supabase = Supabase.instance.client;

  Future createUserProfile(UserProfileModel data) async {
    await supabase.from("profile").insert(data);
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

  
}
