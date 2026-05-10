// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryPostModelImpl _$$DiaryPostModelImplFromJson(Map<String, dynamic> json) =>
    _$DiaryPostModelImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      subject: json['subject'] as String,
      content: json['content'] as String,
      emotion: json['emotion'] as String,
      isDraft: json['isDraft'] as bool? ?? false,
      lockedAt: json['lockedAt'] == null
          ? null
          : DateTime.parse(json['lockedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DiaryPostModelImplToJson(
        _$DiaryPostModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'subject': instance.subject,
      'content': instance.content,
      'emotion': instance.emotion,
    };
