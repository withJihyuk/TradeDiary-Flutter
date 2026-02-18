import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/service/streak_service.dart';

final widgetUpdateProvider = Provider<void>((ref) {
  final diaryState = ref.watch(diaryListProvider);
  final profileState = ref.watch(profileProvider);

  diaryState.whenData((diaries) {
    profileState.whenData((profile) {
      StreakService.updateWidgetData(diaries: diaries, profile: profile);
    });
  });
});
