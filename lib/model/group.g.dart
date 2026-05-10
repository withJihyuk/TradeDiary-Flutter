// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupModelImpl _$$GroupModelImplFromJson(Map<String, dynamic> json) =>
    _$GroupModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['owner_id'] as String,
      deadlineTime: json['deadline_time'] as String? ?? '23:59:00',
      timezone: json['timezone'] as String? ?? 'Asia/Seoul',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      archivedAt: json['archived_at'] == null
          ? null
          : DateTime.parse(json['archived_at'] as String),
    );

Map<String, dynamic> _$$GroupModelImplToJson(_$GroupModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner_id': instance.ownerId,
      'deadline_time': instance.deadlineTime,
      'timezone': instance.timezone,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'archived_at': instance.archivedAt?.toIso8601String(),
    };
