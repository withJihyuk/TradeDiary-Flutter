import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/profile.dart';

class ProfileDataSource {
  final supabase = Supabase.instance.client;

  Future<ProfileModel> getInfo(String userId) async {
    final response = await supabase
        .from("profile")
        .select()
        .eq('id', userId)
        .limit(1)
        .single()
        .catchError((onError) {
      throw Exception('정보를 가져오는데 실패했어요');
    });
    return ProfileModel.fromJson(response);
  }

  Future<void> setNickname(String nickname, String userId) async {
    await supabase
        .from("profile")
        .update({"nickname": nickname})
        .eq('id', userId)
        .catchError((onError) {
          throw Exception('닉네임을 변경하는데 실패했어요');
        });
  }
}
