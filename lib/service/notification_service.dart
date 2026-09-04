import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';

import 'dart:io' show Platform;

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static const String notificationEnabledKey = 'notification_enabled';

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint('알림 응답 받음: ${details.payload}');
      },
    );
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _notifications
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final androidImplementation = _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
      }
    }
  }

  Future<bool> checkPermissions() async {
    try {
      if (Platform.isIOS) {
        final bool? result = await _notifications
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        debugPrint('알림 권한 확인: $result');
        return result ?? false;
      } else if (Platform.isAndroid) {
        final androidImplementation = _notifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

        if (androidImplementation != null) {
          final areNotificationsEnabled = await androidImplementation
              .areNotificationsEnabled();
          return areNotificationsEnabled ?? false;
        }
      }
      return false;
    } catch (e) {
      debugPrint('권한 확인 중 오류 발생: $e');
      return false;
    }
  }

  Future<void> setNotificationEnabled(bool enabled) async {
    try {
      if (enabled) {
        await _requestPermissions();
        final hasPermission = await checkPermissions();
        if (!hasPermission) {
          debugPrint('알림 권한이 없습니다.');
          return;
        }
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(notificationEnabledKey, enabled);

      if (enabled) {
        await scheduleDailyNotification();
      } else {
        await cancelAllNotifications();
      }
    } catch (e) {
      debugPrint('알림 설정 중 오류 발생: $e');
    }
  }

  Future<bool> isNotificationEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final prefEnabled = prefs.getBool(notificationEnabledKey) ?? false;

      if (prefEnabled) {
        return await checkPermissions();
      }
      return false;
    } catch (e) {
      debugPrint('알림 상태 확인 중 오류 발생: $e');
      return false;
    }
  }

  Future<void> scheduleDailyNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_diary_reminder',
      '일기 작성 알림',
      channelDescription: '매일 오후 8시경 일기 작성을 알려드려요.',
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      categoryIdentifier: 'diary_reminder',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
      0,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      id: 0,
      title: '오늘의 일기를 작성해보세요! 📝',
      body: '하루를 마무리하며 오늘 있었던 일을 기록해보세요.',
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  Future<void> showTestNotification() async {
    final hasPermission = await checkPermissions();
    if (!hasPermission) {
      debugPrint('알림 권한이 없습니다.');
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'daily_diary_reminder',
      '일기 작성 알림',
      channelDescription: '매일 오후 8시경 일기 작성을 알려드려요.',
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      categoryIdentifier: 'diary_test',
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      id: 999,
      title: '테스트 알림입니다 📝',
      body: '알림이 잘 작동하고 있습니다!',
      notificationDetails: notificationDetails,
    );
  }
}
