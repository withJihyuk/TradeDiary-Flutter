import 'package:go_router/go_router.dart';
import 'package:trade_diary/views/home/home_page.dart';
import 'package:trade_diary/views/setting/setting_page.dart';

class PageRouter {
  static const _homePage = "/";
  static const _settingPage = "sub";
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: _homePage,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: _settingPage,
            builder: (context, state) => const SettingPage(),
          )
        ],
      )
    ],
  );
}
