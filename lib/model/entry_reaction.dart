// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'entry_reaction.freezed.dart';
part 'entry_reaction.g.dart';

@freezed
class EntryReactionModel with _$EntryReactionModel {
  factory EntryReactionModel({
    required String id,
    @JsonKey(name: 'share_id') required String shareId,
    @JsonKey(name: 'user_id') required String userId,
    @Default('heart') String reaction,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _EntryReactionModel;

  factory EntryReactionModel.fromJson(Map<String, dynamic> json) =>
      _$EntryReactionModelFromJson(json);
}
