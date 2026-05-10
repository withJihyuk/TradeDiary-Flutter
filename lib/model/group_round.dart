// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_round.freezed.dart';
part 'group_round.g.dart';

enum GroupRoundStatus {
  open,
  published,
}

@freezed
class GroupRoundModel with _$GroupRoundModel {
  factory GroupRoundModel({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'round_date') required DateTime roundDate,
    @JsonKey(name: 'deadline_at') required DateTime deadlineAt,
    @Default(GroupRoundStatus.open) GroupRoundStatus status,
    @JsonKey(name: 'published_at') DateTime? publishedAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _GroupRoundModel;

  factory GroupRoundModel.fromJson(Map<String, dynamic> json) =>
      _$GroupRoundModelFromJson(json);
}
