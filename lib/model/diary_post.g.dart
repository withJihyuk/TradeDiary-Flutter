// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiaryPostModel _$DiaryPostModelFromJson(Map<String, dynamic> json) =>
    _DiaryPostModel(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      subject: json['subject'] as String,
      content: json['content'] as String,
      emotion: json['emotion'] as String,
      isDraft: json['isDraft'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DiaryPostModelToJson(_DiaryPostModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'subject': instance.subject,
      'content': instance.content,
      'emotion': instance.emotion,
    };
