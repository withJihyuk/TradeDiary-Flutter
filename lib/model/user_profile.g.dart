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
      profile_url: json['profile_url'] as String,
      gender: json['gender'] as String,
      email: json['email'] as String,
      terms_flag: json['terms_flag'] as bool,
      privacy_flag: json['privacy_flag'] as bool,
      birth: DateTime.parse(json['birth'] as String),
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profile_url': instance.profile_url,
      'gender': instance.gender,
      'email': instance.email,
      'terms_flag': instance.terms_flag,
      'privacy_flag': instance.privacy_flag,
      'birth': instance.birth.toIso8601String(),
    };
