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
import 'package:trade_diary/provider/session.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/widget_update_provider.dart';
import 'package:trade_diary/service/draft_store.dart';

const Size kDesignSize = Size(390, 844);

/// Initializes application services and launches the Flutter app.
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await EnvConfig.initialize();
    await initializeDateFormatting();

    await Supabase.initialize(
      debug: kDebugMode,
      url: EnvConfig.dbUrl,
      publishableKey: EnvConfig.dbKey,
    );

    // 위젯에서 앱 실행 여부를 runApp 전에 동기적으로 확인
    await HomeWidget.setAppGroupId(StreakService.appGroupId);
    final initialUri = await HomeWidget.initiallyLaunchedFromHomeWidget();
    if (NavigationService.isWidgetWriteUri(initialUri)) {
      NavigationService.pendingWidgetRoute = '/write';
    }

    await SentryFlutter.init(
      (options) {
        options.dsn = kDebugMode ? '' : EnvConfig.sentryDsn;
        options.tracesSampleRate = 1.0;
        // ignore: experimental_member_use
        options.profilesSampleRate = 1.0;
      },
      appRunner: () => runApp(
        const ProviderScope(retry: _disableProviderRetry, child: MyApp()),
      ),
    );

    await NotificationService().init();

    HomeWidget.widgetClicked.listen((uri) {
      if (!NavigationService.isWidgetWriteUri(uri)) return;
      if (Supabase.instance.client.auth.currentSession == null) {
        NavigationService.pendingWidgetRoute = '/write';
        PageRouter.router.go('/login');
      } else if (![
        '/write',
        '/select',
      ].contains(PageRouter.router.routeInformationProvider.value.uri.path)) {
        PageRouter.router.push('/write');
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

Duration? _disableProviderRetry(int retryCount, Object error) => null;

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (ref.read(sessionUserProvider) == null) {
      unawaited(StreakService.clearWidgetData());
    }
    _authSubscription = NavigationService.handleAuthStateChange(context, (id) {
      ref.read(sessionUserProvider.notifier).state = id;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(koreanDayProvider);
      ref.invalidate(diaryListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(widgetUpdateProvider);
    ref.watch(draftStoreProvider);
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
