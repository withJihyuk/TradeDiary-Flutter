// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class GroupModel with _$GroupModel {
  factory GroupModel({
    required String id,
    required String name,
    @JsonKey(name: 'owner_id') required String ownerId,
    @JsonKey(name: 'deadline_time') @Default('23:59:00') String deadlineTime,
    @Default('Asia/Seoul') String timezone,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'archived_at') DateTime? archivedAt,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}
