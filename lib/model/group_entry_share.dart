// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_entry_share.freezed.dart';
part 'group_entry_share.g.dart';

@freezed
class GroupEntryShareModel with _$GroupEntryShareModel {
  factory GroupEntryShareModel({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'round_id') required String roundId,
    @JsonKey(name: 'entry_id') required String entryId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'shared_at') required DateTime sharedAt,
    @JsonKey(name: 'canceled_at') DateTime? canceledAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _GroupEntryShareModel;

  factory GroupEntryShareModel.fromJson(Map<String, dynamic> json) =>
      _$GroupEntryShareModelFromJson(json);
}
