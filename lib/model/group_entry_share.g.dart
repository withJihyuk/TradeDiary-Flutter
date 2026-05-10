// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_entry_share.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupEntryShareModelImpl _$$GroupEntryShareModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupEntryShareModelImpl(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      roundId: json['round_id'] as String,
      entryId: json['entry_id'] as String,
      userId: json['user_id'] as String,
      sharedAt: DateTime.parse(json['shared_at'] as String),
      canceledAt: json['canceled_at'] == null
          ? null
          : DateTime.parse(json['canceled_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$GroupEntryShareModelImplToJson(
        _$GroupEntryShareModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'round_id': instance.roundId,
      'entry_id': instance.entryId,
      'user_id': instance.userId,
      'shared_at': instance.sharedAt.toIso8601String(),
      'canceled_at': instance.canceledAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
