import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiaryNotifier extends StateNotifier<bool> {
  DiaryNotifier(this.ref) : super(false);

  final Ref ref;

  Future<void> increment() async {
    final result = Supabase.instance.client.from("diary").insert({
      // repository 와 연결 필요
    });
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
