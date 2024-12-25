import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryNotifier extends StateNotifier<DiaryPostModel> {
  DiaryNotifier()
      : super(DiaryPostModel(
            userId: "",
            subject: "",
            date: DateTime.now(),
            content: "",
            emotion: "배고픈감자",
            image: [],
            isPrivate: false));

  void setSubject(String subject) {
    state = state.copyWith(subject: subject);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  void setEmotion(String emotion) {
    state = state.copyWith(emotion: emotion);
  }

  void setImage(List<String> image) {
    state = state.copyWith(image: image);
  }

  void setIsPrivate(bool isPrivate) {
    state = state.copyWith(isPrivate: isPrivate);
  }
}

final diaryProvider =
    StateNotifierProvider<DiaryNotifier, DiaryPostModel>((ref) {
  return DiaryNotifier();
});
