import 'package:trade_diary/model/diary_post.dart';

DateTime diaryEffectiveDateTime(DiaryPostModel diary) {
  return diary.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
}

DateTime diaryDateOnly(DiaryPostModel diary) {
  final dt = diaryEffectiveDateTime(diary);
  return DateTime(dt.year, dt.month, dt.day);
}
