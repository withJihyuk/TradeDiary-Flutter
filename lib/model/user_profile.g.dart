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
      gender: json['gender'] as String,
      email: json['email'] as String,
      termsFlag: json['termsFlag'] as bool,
      privacyFlag: json['privacyFlag'] as bool,
      birth: DateTime.parse(json['birth'] as String),
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'profileUrl': instance.profileUrl,
      'gender': instance.gender,
      'email': instance.email,
      'termsFlag': instance.termsFlag,
      'privacyFlag': instance.privacyFlag,
      'birth': instance.birth.toIso8601String(),
    };
