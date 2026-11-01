import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trade_diary/model/diary_post.dart';

DiaryPostModel _initialDiary() {
  return DiaryPostModel(userId: "", subject: "", content: "", emotion: "배고픈감자");
}

class WriteDiaryNotifier extends StateNotifier<DiaryPostModel> {
  WriteDiaryNotifier() : super(_initialDiary());

  void setSubject(String subject) {
    state = state.copyWith(subject: subject);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  void setEmotion(String emotion) {
    state = state.copyWith(emotion: emotion);
  }

  void reset() {
    state = _initialDiary();
  }
}

final diaryProvider = StateNotifierProvider<WriteDiaryNotifier, DiaryPostModel>(
  (ref) {
    return WriteDiaryNotifier();
  },
);

final quillControllerProvider = StateProvider.autoDispose<QuillController>((
  ref,
) {
  final controller = QuillController.basic();
  ref.onDispose(controller.dispose);
  return controller;
});

/// 툴바 서브패널 상태
enum ToolbarPanel { none, add, text }

final toolbarPanelProvider = StateProvider.autoDispose<ToolbarPanel>(
  (ref) => ToolbarPanel.none,
);

final imageImportingProvider = StateProvider.autoDispose<bool>((ref) => false);

/// 툴바에서 마지막으로 선택한 인라인 스타일 의도
final inlineTypingStyleProvider = StateProvider<Style>((ref) => const Style());

/// 스타일 의도가 적용되어야 하는 기준 커서 위치
final inlineTypingOffsetProvider = StateProvider<int?>((ref) => null);
