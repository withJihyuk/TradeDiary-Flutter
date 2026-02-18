import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/util/level.dart';

class StreakService {
  static const String appGroupId = 'group.com.example.tradeDiary';
  static const String iOSWidgetName = 'PotatoDiaryWidget';
  static const String androidWidgetName = 'PotatoDiaryWidget';

  static int computeStreak(List<DiaryPostModel> diaries) {
    if (diaries.isEmpty) return 0;

    final dates = diaries
        .map((d) => DateTime(d.date.year, d.date.month, d.date.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final yesterday = todayOnly.subtract(const Duration(days: 1));

    if (dates.first != todayOnly && dates.first != yesterday) return 0;

    int streak = 1;
    for (int i = 1; i < dates.length; i++) {
      final diff = dates[i - 1].difference(dates[i]).inDays;
      if (diff == 1) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  static String getTodayEmotion(List<DiaryPostModel> diaries) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    for (final diary in diaries) {
      final diaryDate = DateTime(diary.date.year, diary.date.month, diary.date.day);
      if (diaryDate == todayOnly) return diary.emotion;
    }
    return '';
  }

  static Future<void> updateWidgetData({
    required List<DiaryPostModel> diaries,
    required ProfileModel profile,
  }) async {
    try {
      final levelSystem = LevelSystem();
      final streak = computeStreak(diaries);
      final todayEmotion = getTodayEmotion(diaries);
      final currentLevel = levelSystem.getLevel(profile.exp);
      final nextLevelExp = currentLevel <= levelSystem.levelExp.length
          ? levelSystem.levelExp[currentLevel - 1]
          : profile.exp;

      await HomeWidget.setAppGroupId(appGroupId);
      await Future.wait([
        HomeWidget.saveWidgetData<int>('streak_count', streak),
        HomeWidget.saveWidgetData<String>('today_emotion', todayEmotion),
        HomeWidget.saveWidgetData<int>('current_level', currentLevel),
        HomeWidget.saveWidgetData<int>('current_exp', profile.exp),
        HomeWidget.saveWidgetData<int>('next_level_exp', nextLevelExp),
        HomeWidget.saveWidgetData<String>('nickname', profile.nickname),
      ]);

      await HomeWidget.updateWidget(
        iOSName: iOSWidgetName,
        androidName: androidWidgetName,
      );
    } catch (e) {
      debugPrint('위젯 데이터 업데이트 실패: $e');
    }
  }

  static Future<void> clearWidgetData() async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
      await Future.wait([
        HomeWidget.saveWidgetData<int>('streak_count', 0),
        HomeWidget.saveWidgetData<String>('today_emotion', ''),
        HomeWidget.saveWidgetData<int>('current_level', 0),
        HomeWidget.saveWidgetData<int>('current_exp', 0),
        HomeWidget.saveWidgetData<int>('next_level_exp', 0),
        HomeWidget.saveWidgetData<String>('nickname', ''),
      ]);
      await HomeWidget.updateWidget(
        iOSName: iOSWidgetName,
        androidName: androidWidgetName,
      );
    } catch (e) {
      debugPrint('위젯 데이터 초기화 실패: $e');
    }
  }
}
