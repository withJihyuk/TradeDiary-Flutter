// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EntryCommentModelImpl _$$EntryCommentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EntryCommentModelImpl(
      id: json['id'] as String,
      shareId: json['share_id'] as String,
      userId: json['user_id'] as String,
      body: json['body'] as String,
      hiddenAt: json['hidden_at'] == null
          ? null
          : DateTime.parse(json['hidden_at'] as String),
      hiddenBy: json['hidden_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$EntryCommentModelImplToJson(
        _$EntryCommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'share_id': instance.shareId,
      'user_id': instance.userId,
      'body': instance.body,
      'hidden_at': instance.hiddenAt?.toIso8601String(),
      'hidden_by': instance.hiddenBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
