// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryPostModelImpl _$$DiaryPostModelImplFromJson(Map<String, dynamic> json) =>
    _$DiaryPostModelImpl(
      subject: json['subject'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      image: (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      isPrivate: json['isPrivate'] as bool,
    );

Map<String, dynamic> _$$DiaryPostModelImplToJson(
        _$DiaryPostModelImpl instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'content': instance.content,
      'date': instance.date.toIso8601String(),
      'image': instance.image,
      'isPrivate': instance.isPrivate,
    };
