import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DiaryImageNotifier extends StateNotifier<List<XFile>> {
  DiaryImageNotifier() : super([]);

  void addImage(XFile image) {
    debugPrint("addImage");
    state = [...state, image];
  }

  void removeImage(int index) {
    if (index < 0 || index >= state.length) return;
    state = [...state]..removeAt(index);
  }

  void clearImages() {
    state = [];
  }
}

final diaryImageProvider =
    StateNotifierProvider<DiaryImageNotifier, List<XFile>>((ref) {
  return DiaryImageNotifier();
});
