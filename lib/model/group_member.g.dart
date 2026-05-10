// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupMemberModelImpl _$$GroupMemberModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupMemberModelImpl(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      userId: json['user_id'] as String,
      role: $enumDecodeNullable(_$GroupMemberRoleEnumMap, json['role']) ??
          GroupMemberRole.member,
      status: $enumDecodeNullable(_$GroupMemberStatusEnumMap, json['status']) ??
          GroupMemberStatus.active,
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
      leftAt: json['left_at'] == null
          ? null
          : DateTime.parse(json['left_at'] as String),
    );

Map<String, dynamic> _$$GroupMemberModelImplToJson(
        _$GroupMemberModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'user_id': instance.userId,
      'role': _$GroupMemberRoleEnumMap[instance.role]!,
      'status': _$GroupMemberStatusEnumMap[instance.status]!,
      'joined_at': instance.joinedAt?.toIso8601String(),
      'left_at': instance.leftAt?.toIso8601String(),
    };

const _$GroupMemberRoleEnumMap = {
  GroupMemberRole.owner: 'owner',
  GroupMemberRole.member: 'member',
};

const _$GroupMemberStatusEnumMap = {
  GroupMemberStatus.active: 'active',
  GroupMemberStatus.left: 'left',
  GroupMemberStatus.removed: 'removed',
};
