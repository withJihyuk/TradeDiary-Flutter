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

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  static const String notificationEnabledKey = 'notification_enabled';

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      // iOS에서는 초기화 시점에 권한 요청하지 않도록 설정
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint('알림 응답 받음: ${details.payload}');
      },
    );
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final androidImplementation = _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      
      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
        await androidImplementation.requestExactAlarmsPermission();
      }
    }
  }

  Future<bool> checkPermissions() async {
    try {
      if (Platform.isIOS) {
        final bool? result = await _notifications.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        debugPrint('알림 권한 확인: $result');
        return result ?? false;
      } else if (Platform.isAndroid) {
        final androidImplementation = _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
            
        if (androidImplementation != null) {
          final areNotificationsEnabled = await androidImplementation.areNotificationsEnabled();
          final hasExactAlarmPermission = await androidImplementation.canScheduleExactNotifications();
          
          return (areNotificationsEnabled ?? false) && (hasExactAlarmPermission ?? false);
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
    // 알림 채널 생성
    const androidDetails = AndroidNotificationDetails(
      'diary_reminder',
      '일기 작성 알림',
      channelDescription: '매일 오후 8시에 일기 작성을 알려드립니다.',
      importance: Importance.high,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      category: AndroidNotificationCategory.reminder,
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

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20, // 오후 8시
      0,
    );

    // 이미 오후 8시가 지났다면 다음 날로 설정
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      0,
      '오늘의 일기를 작성해보세요! 📝',
      '하루를 마무리하며 오늘 있었던 일을 기록해보세요.',
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  Future<void> showTestNotification() async {
    // 권한 확인
    final hasPermission = await checkPermissions();
    if (!hasPermission) {
      debugPrint('알림 권한이 없습니다.');
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'diary_test',
      '테스트 알림',
      channelDescription: '알림 테스트를 위한 채널입니다.',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      category: AndroidNotificationCategory.message,
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
      999,
      '테스트 알림입니다 📝',
      '알림이 잘 작동하고 있습니다!',
      notificationDetails,
    );
  }
} 