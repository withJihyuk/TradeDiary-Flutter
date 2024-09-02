// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UploadImageModelImpl _$$UploadImageModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UploadImageModelImpl(
      image: const Uint8ListConverter().fromJson(json['image'] as List<int>?),
      subject: json['subject'] as String,
    );

Map<String, dynamic> _$$UploadImageModelImplToJson(
        _$UploadImageModelImpl instance) =>
    <String, dynamic>{
      'image': const Uint8ListConverter().toJson(instance.image),
      'subject': instance.subject,
    };
