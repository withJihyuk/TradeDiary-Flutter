import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/config/env.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trade_diary/designSystem/theme_data.dart';
import 'package:trade_diary/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:trade_diary/util/app_exception.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:trade_diary/util/navigation_service.dart';
import 'package:trade_diary/service/notification_service.dart';
import 'package:trade_diary/service/streak_service.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Size kDesignSize = Size(390, 844);

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await EnvConfig.initialize();
    await initializeDateFormatting();

    if (EnvConfig.dbUrl.isEmpty || EnvConfig.dbKey.isEmpty) {
      throw ValidationException('데이터베이스 설정이 올바르지 않습니다');
    }

    await Supabase.initialize(
      debug: kDebugMode,
      url: EnvConfig.dbUrl,
      anonKey: EnvConfig.dbKey,
    );

    if (!kDebugMode && EnvConfig.sentryDsn.isEmpty) {
      throw ValidationException('Sentry DSN이 설정되지 않았습니다');
    }

    // 위젯에서 앱 실행 여부를 runApp 전에 동기적으로 확인
    await HomeWidget.setAppGroupId(StreakService.appGroupId);
    final initialUri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (initialUri != null) {
      final prefs = await SharedPreferences.getInstance();
      final hasTodayDiary = prefs.getBool('has_today_diary') ?? false;
      if (!hasTodayDiary) {
        NavigationService.pendingWidgetRoute = '/write';
      }
    }

    await SentryFlutter.init(
      (options) {
        options.dsn = kDebugMode ? '' : EnvConfig.sentryDsn;
        options.tracesSampleRate = 1.0;
        // ignore: experimental_member_use
        options.profilesSampleRate = 1.0;
      },
      appRunner: () => runApp(const ProviderScope(child: MyApp())),
    );

    await NotificationService().init();

    HomeWidget.widgetClicked.listen((uri) async {
      if (uri != null) {
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          final prefs = await SharedPreferences.getInstance();
          final hasTodayDiary = prefs.getBool('has_today_diary') ?? false;
          if (!hasTodayDiary) {
            PageRouter.router.push('/write');
          }
        }
      }
    });
  } catch (e, stackTrace) {
    if (e is AppException) {
      debugPrint('초기화 중 오류 발생: ${e.message}');
    } else {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
        hint: Hint.withMap({'error_source': 'app_initialization'}),
      );
    }
    rethrow;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = NavigationService.handleAuthStateChange(context);
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: kDesignSize,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '감자일기',
          theme: customThemeData,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ko', 'KR')],
          routeInformationParser: PageRouter.router.routeInformationParser,
          routeInformationProvider: PageRouter.router.routeInformationProvider,
          routerDelegate: PageRouter.router.routerDelegate,
        );
      },
    );
  }
}
