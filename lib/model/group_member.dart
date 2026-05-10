// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_member.freezed.dart';
part 'group_member.g.dart';

enum GroupMemberRole { owner, member }

enum GroupMemberStatus { active, left, removed }

@freezed
class GroupMemberModel with _$GroupMemberModel {
  factory GroupMemberModel({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'user_id') required String userId,
    @Default(GroupMemberRole.member) GroupMemberRole role,
    @Default(GroupMemberStatus.active) GroupMemberStatus status,
    @JsonKey(name: 'joined_at') DateTime? joinedAt,
    @JsonKey(name: 'left_at') DateTime? leftAt,
  }) = _GroupMemberModel;

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberModelFromJson(json);
}
