// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_invite.freezed.dart';
part 'group_invite.g.dart';

@freezed
class GroupInviteModel with _$GroupInviteModel {
  factory GroupInviteModel({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    required String code,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'revoked_at') DateTime? revokedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _GroupInviteModel;

  factory GroupInviteModel.fromJson(Map<String, dynamic> json) =>
      _$GroupInviteModelFromJson(json);
}
