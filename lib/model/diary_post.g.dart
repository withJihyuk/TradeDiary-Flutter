// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryPostModelImpl _$$DiaryPostModelImplFromJson(Map<String, dynamic> json) =>
    _$DiaryPostModelImpl(
      id: (json['id'] as num?)?.toInt(),
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DiaryPostModelImplToJson(
        _$DiaryPostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
      'userId': instance.userId,
    };
