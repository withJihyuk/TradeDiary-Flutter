// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileModelImpl(
      id: json['id'] as String,
      nickname: json['nickname'] as String,
      profileUrl: json['profileUrl'] as String,
      description: json['description'] as String,
      isPrivate: json['isPrivate'] as bool,
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profileUrl': instance.profileUrl,
      'description': instance.description,
      'isPrivate': instance.isPrivate,
    };
