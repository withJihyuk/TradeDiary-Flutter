import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/util/level.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/util/diary_post_date_util.dart';

class StreakService {
  static const String appGroupId = 'group.com.example.tradeDiary';
  static const String iOSWidgetName = 'PotatoDiaryWidget';
  static const String androidWidgetName = 'PotatoDiaryWidget';

  static String getTodayEmotion(List<DiaryPostModel> diaries) {
    final today = seoulTime(DateTime.now());
    final todayOnly = DateTime.utc(today.year, today.month, today.day);

    for (final diary in diaries) {
      final diaryDate = diaryDateOnly(diary);
      if (diaryDate == todayOnly) return diary.emotion;
    }
    return '';
  }

  static String getWeeklyEmotions(List<DiaryPostModel> diaries) {
    final now = seoulTime(DateTime.now());
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final Map<String, String> weekData = {};

    for (int i = 0; i < 7; i++) {
      final day = DateTime.utc(monday.year, monday.month, monday.day + i);
      final key =
          "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
      for (final diary in diaries) {
        final d = diaryDateOnly(diary);
        if (d == day) {
          weekData[key] = diary.emotion;
          break;
        }
      }
    }
    return jsonEncode(weekData);
  }

  static Future<void> _pending = Future.value();
  static Future<void> _enqueue(Future<void> Function() action) {
    final next = _pending.catchError((Object _) {}).then((_) => action());
    _pending = next;
    return next.catchError((Object e) {
      debugPrint('위젯 데이터 갱신 실패');
    });
  }

  static Future<void> updateWidgetData({
    required List<DiaryPostModel> diaries,
    required ProfileModel profile,
  }) => _enqueue(() async {
    if (Supabase.instance.client.auth.currentUser?.id != profile.id) return;
    final levels = LevelSystem();
    final level = levels.getLevel(profile.exp);
    final span = levels.expToNextLevel(profile.exp);
    final now = seoulTime(DateTime.now());
    var day = DateTime.utc(now.year, now.month, now.day);
    final dates = diaries.map(diaryDateOnly).toSet();
    if (!dates.contains(day)) day = day.subtract(const Duration(days: 1));
    var streak = 0;
    while (dates.contains(day)) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }
    await HomeWidget.setAppGroupId(appGroupId);
    await Future.wait([
      HomeWidget.saveWidgetData<String>('nickname', profile.nickname),
      HomeWidget.saveWidgetData<String>(
        'weekly_emotions',
        getWeeklyEmotions(diaries),
      ),
      HomeWidget.saveWidgetData<String>(
        'today_emotion',
        getTodayEmotion(diaries),
      ),
      HomeWidget.saveWidgetData<String>(
        'data_date',
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      ),
      HomeWidget.saveWidgetData<bool>('logged_in', true),
      HomeWidget.saveWidgetData<int>('streak_count', streak),
      HomeWidget.saveWidgetData<int>('current_level', level),
      HomeWidget.saveWidgetData<int>(
        'current_exp',
        (profile.exp - levels.getCurrentLevelExp(level)).clamp(0, span),
      ),
      HomeWidget.saveWidgetData<int>('next_level_exp', span),
    ]);
    await HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
      androidName: androidWidgetName,
    );
  });
  static Future<void> clearWidgetData() => _enqueue(() async {
    await HomeWidget.setAppGroupId(appGroupId);
    await Future.wait([
      HomeWidget.saveWidgetData<String>('nickname', ''),
      HomeWidget.saveWidgetData<String>('weekly_emotions', '{}'),
      HomeWidget.saveWidgetData<String>('today_emotion', ''),
      HomeWidget.saveWidgetData<String>('data_date', ''),
      HomeWidget.saveWidgetData<bool>('logged_in', false),
      for (final key in [
        'streak_count',
        'current_level',
        'current_exp',
        'next_level_exp',
      ])
        HomeWidget.saveWidgetData<int>(key, 0),
    ]);
    await HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
      androidName: androidWidgetName,
    );
  });
}
