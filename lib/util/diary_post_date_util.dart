import 'package:trade_diary/model/diary_post.dart';

// Return UTC-tagged calendar components so device timezone and DST never affect Seoul dates.
DateTime seoulTime(DateTime value) =>
    value.toUtc().add(const Duration(hours: 9));
DateTime diaryEffectiveDateTime(DiaryPostModel diary) {
  if (!diary.isDraft && diary.diaryDate != null) {
    return DateTime.parse(diary.diaryDate!);
  }
  return seoulTime(
    (diary.isDraft ? diary.updatedAt : diary.completedAt) ??
        diary.createdAt ??
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
  );
}

DateTime diaryDateOnly(DiaryPostModel diary) {
  final dt = diaryEffectiveDateTime(diary);
  return DateTime.utc(dt.year, dt.month, dt.day);
}
