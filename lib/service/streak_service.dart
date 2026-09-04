import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/util/diary_post_date_util.dart';

class StreakService {
  static const String appGroupId = 'group.com.example.tradeDiary';
  static const String iOSWidgetName = 'PotatoDiaryWidget';
  static const String androidWidgetName = 'PotatoDiaryWidget';

  static String getTodayEmotion(List<DiaryPostModel> diaries) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    for (final diary in diaries) {
      final diaryDate = diaryDateOnly(diary);
      if (diaryDate == todayOnly) return diary.emotion;
    }
    return '';
  }

  static String getWeeklyEmotions(List<DiaryPostModel> diaries) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final Map<String, String> weekData = {};

    for (int i = 0; i < 7; i++) {
      final day = DateTime(monday.year, monday.month, monday.day + i);
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

  static Future<void> updateWidgetData({
    required List<DiaryPostModel> diaries,
    required ProfileModel profile,
  }) async {
    try {
      final todayEmotion = getTodayEmotion(diaries);

      await HomeWidget.setAppGroupId(appGroupId);
      await Future.wait([
        HomeWidget.saveWidgetData<String>('nickname', profile.nickname),
        HomeWidget.saveWidgetData<String>(
          'weekly_emotions',
          getWeeklyEmotions(diaries),
        ),
      ]);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_today_diary', todayEmotion.isNotEmpty);

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
        HomeWidget.saveWidgetData<String>('nickname', ''),
        HomeWidget.saveWidgetData<String>('weekly_emotions', '{}'),
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
