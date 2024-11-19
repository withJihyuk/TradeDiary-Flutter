import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_post.freezed.dart';
part 'diary_post.g.dart';

@freezed
class DiaryPostModel with _$DiaryPostModel {
  factory DiaryPostModel(
      {required String userId,
      required String content,
      required bool isPrivate}) = _DiaryPostModel;

  factory DiaryPostModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryPostModelFromJson(json);
}
