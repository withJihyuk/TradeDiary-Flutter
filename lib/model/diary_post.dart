import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_post.freezed.dart';
part 'diary_post.g.dart';

@freezed
class DiaryPostModel with _$DiaryPostModel {
  factory DiaryPostModel({
    required int id,
    required String content,
    required DateTime createdAt,
    required DateTime deleteAt,
    required int userId,
  }) = _DiaryPostModel;

  factory DiaryPostModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryPostModelJson(json);
}
