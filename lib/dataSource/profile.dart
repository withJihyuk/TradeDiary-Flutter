import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/util/app_exception.dart';

class ProfileDataSource {
  final supabase = Supabase.instance.client;

  Future<ProfileModel> getInfo(String userId) async {
    try {
      final response = await supabase
          .from("profile")
          .select()
          .eq('id', userId)
          .limit(1)
          .single();
      return ProfileModel.fromJson(response);
    } catch (e) {
      throw DatabaseException('정보를 가져오는데 실패했어요', originalError: e);
    }
  }

  Future<void> setNickname(String nickname, String userId) async {
    try {
      await supabase
          .from("profile")
          .update({"nickname": nickname})
          .eq('id', userId);
    } catch (e) {
      throw DatabaseException('닉네임을 변경하는데 실패했어요', originalError: e);
    }
  }
}
