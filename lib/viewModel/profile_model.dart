import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/repository/profile.dart';

class ProfileViewModel {
  final repo = ProfileRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  Future<void> setNickname(String nickname, String userId) async {
    return await repo.setNickname(nickname, userId);
  }

  Future<ProfileModel> getInfo() async {
    return await repo.getInfo(userId);
  }
}
