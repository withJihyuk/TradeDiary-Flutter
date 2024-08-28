import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    required String id,
    required String nickname,
    required String profile_url,
    required String gender,
    required String email,
    required bool terms_flag,
    required bool privacy_flag,
    required DateTime birth,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}
