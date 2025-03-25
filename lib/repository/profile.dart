import 'package:trade_diary/dataSource/profile.dart';
import 'package:trade_diary/model/profile.dart';

class ProfileRepo {
  final datasource = ProfileDataSource();

  Future<ProfileModel> getInfo(String userId) async {
    return await datasource.getInfo(userId);
  }

  Future<void> setNickname(String nickname, String userId) async {
    return await datasource.setNickname(nickname, userId);
  }

  Future<void> addExp(int exp, String userId) async {
    return await datasource.addExp(exp, userId);
  }
}
