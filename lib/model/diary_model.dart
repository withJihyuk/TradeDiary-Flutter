import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryNotifier extends StateNotifier<bool> {
  DiaryNotifier(this.ref) : super(false);

  final Ref ref;

  Future<void> increment() async {
    // insert rule
    state = true;
  }

  Future<void> checkUserDiary() async {
    // if user has diary -> true
    // else -> false
  }
}

final counterStateProvider = StateNotifierProvider<DiaryNotifier, bool>((ref) {
  return DiaryNotifier(ref);
});
