// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryPostModelImpl _$$DiaryPostModelImplFromJson(Map<String, dynamic> json) =>
    _$DiaryPostModelImpl(
      userId: json['userId'] as String,
      content: json['content'] as String,
      isPrivate: json['isPrivate'] as bool,
    );

Map<String, dynamic> _$$DiaryPostModelImplToJson(
        _$DiaryPostModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'content': instance.content,
      'isPrivate': instance.isPrivate,
    };
