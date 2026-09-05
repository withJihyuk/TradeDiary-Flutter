import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/service/streak_service.dart';

final widgetUpdateProvider = FutureProvider<void>((ref) async {
  final diaryState = ref.watch(diaryListProvider);
  final profileState = ref.watch(profileProvider);

  final diaries = diaryState.value;
  final profile = profileState.value;
  if (diaries != null && profile != null) {
    await StreakService.updateWidgetData(diaries: diaries, profile: profile);
  }
});
