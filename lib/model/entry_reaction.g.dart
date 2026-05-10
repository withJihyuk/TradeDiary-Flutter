// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_reaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntryReactionModelImpl _$$EntryReactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EntryReactionModelImpl(
      id: json['id'] as String,
      shareId: json['share_id'] as String,
      userId: json['user_id'] as String,
      reaction: json['reaction'] as String? ?? 'heart',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$EntryReactionModelImplToJson(
        _$EntryReactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'share_id': instance.shareId,
      'user_id': instance.userId,
      'reaction': instance.reaction,
      'created_at': instance.createdAt?.toIso8601String(),
    };
