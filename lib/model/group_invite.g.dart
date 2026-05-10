// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupInviteModelImpl _$$GroupInviteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupInviteModelImpl(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      code: json['code'] as String,
      createdBy: json['created_by'] as String,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      revokedAt: json['revoked_at'] == null
          ? null
          : DateTime.parse(json['revoked_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$GroupInviteModelImplToJson(
        _$GroupInviteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'code': instance.code,
      'created_by': instance.createdBy,
      'expires_at': instance.expiresAt?.toIso8601String(),
      'revoked_at': instance.revokedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
