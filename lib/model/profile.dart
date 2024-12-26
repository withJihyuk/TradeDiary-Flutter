import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  factory ProfileModel({
    required String id,
    required String nickname,
    required String email,
    required int level,
    required int exp,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
