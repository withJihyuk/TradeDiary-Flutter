import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:trade_diary/dataSource/profile.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/util/app_exception.dart';

class ProfileViewModel {
  final _dataSource = ProfileDataSource();

  String get userId {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      throw AuthenticationException('로그인이 필요합니다');
    }
    return user.id;
  }

  Future<void> setNickname(String nickname) async {
    return await _dataSource.setNickname(nickname, userId);
  }

  Future<ProfileModel> getInfo() async {
    return await _dataSource.getInfo(userId);
  }
}
