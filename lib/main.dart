import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/desginSystem/theme_data.dart';
import 'package:trade_diary/router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await Supabase.initialize(
    debug: true,
    url: dotenv.env['DB_URL']!,
    anonKey: dotenv.env['DB_KEY']!,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    navigationByState(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '교환일기',
      theme: customThemeData,
      routeInformationParser: PageRouter.router.routeInformationParser,
      routeInformationProvider: PageRouter.router.routeInformationProvider,
      routerDelegate: PageRouter.router.routerDelegate,
    );
  }
}

void navigationByState(BuildContext context) {
  final supabase = Supabase.instance.client;
  supabase.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;

    try {
      switch (event) {
        case AuthChangeEvent.initialSession:
          if (context.mounted && data.session != null) {
            PageRouter.router.go("/home");
          } else {
            PageRouter.router.go("/onBoarding");
          }
          break;

        case AuthChangeEvent.signedIn:
          if (context.mounted) {
            PageRouter.router.go("/home");
          }
          break;

        case AuthChangeEvent.signedOut:
          if (context.mounted) {
            PageRouter.router.go("/onBoarding");
          }
          break;

        default:
          break;
      }
    } catch (e) {
      if (context.mounted) {
        PageRouter.router.go("/onBoarding");
      }
    }
  });
}
