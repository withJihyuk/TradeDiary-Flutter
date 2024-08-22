// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryPostModelImpl _$$DiaryPostModelImplFromJson(Map<String, dynamic> json) =>
    _$DiaryPostModelImpl(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      deleteAt: DateTime.parse(json['deleteAt'] as String),
      userId: (json['userId'] as num).toInt(),
      isPrivate: json['isPrivate'] as bool,
    );

Map<String, dynamic> _$$DiaryPostModelImplToJson(
        _$DiaryPostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'deleteAt': instance.deleteAt.toIso8601String(),
      'userId': instance.userId,
      'isPrivate': instance.isPrivate,
    };
