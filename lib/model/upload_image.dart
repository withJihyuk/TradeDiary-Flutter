import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_image.freezed.dart';
part 'upload_image.g.dart';

class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
  const Uint8ListConverter();

  @override
  Uint8List? fromJson(List<int>? json) {
    return json == null ? null : Uint8List.fromList(json);
  }

  @override
  List<int>? toJson(Uint8List? object) {
    return object?.toList();
  }
}

@freezed
class UploadImageModel with _$UploadImageModel {
  @Uint8ListConverter()
  factory UploadImageModel({
    required Uint8List? image,
    required String subject,
  }) = _UploadImageModel;

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      _$UploadImageModelFromJson(json);
}
