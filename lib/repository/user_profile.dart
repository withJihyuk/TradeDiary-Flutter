import 'package:trade_diary/dataSource/user_profile.dart';

class UserProfileRepo {
  final datasource = UserProfileDataSource();

  Future<List> getUserProfile(String userId) async {
    return await datasource.getUserProfile(userId).onError((error, stackTrace) {
      return [];
    });
  }
}
