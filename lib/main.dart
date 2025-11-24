import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trade_diary/designSystem/theme_data.dart';
import 'package:trade_diary/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:trade_diary/util/app_exception.dart';
import 'package:trade_diary/util/navigation_service.dart';
import 'package:trade_diary/service/notification_service.dart';

const Size kDesignSize = Size(390, 844);

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await dotenv.load(fileName: '.env');
    await initializeDateFormatting();

    final dbUrl = dotenv.env['DB_URL'];
    final dbKey = dotenv.env['DB_KEY'];
    final sentryDsn = dotenv.env['SENTRY_DSN'];

    await Supabase.initialize(
      debug: kDebugMode,
      url: dbUrl!,
      anonKey: dbKey!,
    );

    await SentryFlutter.init(
      (options) {
        options.dsn = kDebugMode ? '' : sentryDsn!;
        options.tracesSampleRate = 1.0;
        options.profilesSampleRate = 1.0;
      },
      appRunner: () => runApp(const ProviderScope(child: MyApp())),
    );

    runApp(const ProviderScope(child: MyApp()));
    await NotificationService().init();
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService.handleAuthStateChange(context);
    return ScreenUtilInit(
      designSize: kDesignSize,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '감자일기',
          theme: customThemeData,
          routeInformationParser: PageRouter.router.routeInformationParser,
          routeInformationProvider: PageRouter.router.routeInformationProvider,
          routerDelegate: PageRouter.router.routerDelegate,
        );
      },
    );
  }
}
