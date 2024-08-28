import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_follow.freezed.dart';
part 'user_follow.g.dart';

@freezed
class UserFollowModel with _$UserFollowModel {
  factory UserFollowModel({
    required String toUser,
    required String fromUser,
  }) = _UserFollowModel;

  factory UserFollowModel.fromJson(Map<String, dynamic> json) =>
      _$UserFollowModelFromJson(json);
}
