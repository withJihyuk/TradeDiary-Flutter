// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_round.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupRoundModelImpl _$$GroupRoundModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupRoundModelImpl(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      roundDate: DateTime.parse(json['round_date'] as String),
      deadlineAt: DateTime.parse(json['deadline_at'] as String),
      status: $enumDecodeNullable(_$GroupRoundStatusEnumMap, json['status']) ??
          GroupRoundStatus.open,
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$GroupRoundModelImplToJson(
        _$GroupRoundModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'round_date': instance.roundDate.toIso8601String(),
      'deadline_at': instance.deadlineAt.toIso8601String(),
      'status': _$GroupRoundStatusEnumMap[instance.status]!,
      'published_at': instance.publishedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$GroupRoundStatusEnumMap = {
  GroupRoundStatus.open: 'open',
  GroupRoundStatus.published: 'published',
};
