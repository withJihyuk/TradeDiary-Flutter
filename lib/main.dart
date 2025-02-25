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
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/util/navigation_service.dart';

// 디자인 사이즈 상수
const Size kDesignSize = Size(390, 844);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: '.env');
  await initializeDateFormatting();
  await Supabase.initialize(
    debug: false, // 프로덕션 환경에서는 false로 설정
    url: dotenv.env['DB_URL']!,
    anonKey: dotenv.env['DB_KEY']!,
  );
  
  await SentryFlutter.init(
    (options) {
      options.dsn = kDebugMode ? '' : dotenv.env['SENTRY_DSN']!;
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const ProviderScope(child: MyApp())),
  );
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
