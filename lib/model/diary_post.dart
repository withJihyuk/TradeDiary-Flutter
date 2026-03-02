// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_post.freezed.dart';
part 'diary_post.g.dart';

@freezed
class DiaryPostModel with _$DiaryPostModel {
  factory DiaryPostModel({
    @JsonKey(includeToJson: false) String? id,
    required String userId,
    required String subject,
    required String content,
    required String emotion,
    @JsonKey(includeToJson: false) @Default(false) bool isDraft,
    @JsonKey(includeToJson: false) DateTime? createdAt,
    @JsonKey(includeToJson: false) DateTime? updatedAt,
  }) = _DiaryPostModel;

  factory DiaryPostModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryPostModelFromJson(json);
}
