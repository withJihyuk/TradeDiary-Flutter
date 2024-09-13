import 'package:trade_diary/repository/user_profile.dart';

class UserProfileViewModel {
  final repo = UserProfileRepo();
  Future<List> getUserProfile(String userId) {
      return repo.getUserProfile(userId);
  }
}