// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry_comment.freezed.dart';
part 'entry_comment.g.dart';

@freezed
class EntryCommentModel with _$EntryCommentModel {
  factory EntryCommentModel({
    required String id,
    @JsonKey(name: 'share_id') required String shareId,
    @JsonKey(name: 'user_id') required String userId,
    required String body,
    @JsonKey(name: 'hidden_at') DateTime? hiddenAt,
    @JsonKey(name: 'hidden_by') String? hiddenBy,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _EntryCommentModel;

  factory EntryCommentModel.fromJson(Map<String, dynamic> json) =>
      _$EntryCommentModelFromJson(json);
}
