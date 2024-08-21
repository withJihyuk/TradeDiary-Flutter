import 'package:go_router/go_router.dart';
import 'package:trade_diary/view/character/my_character.dart';

import 'package:trade_diary/view/diary/read_page.dart';
import 'package:trade_diary/view/diary/write_page.dart';
import 'package:trade_diary/view/home/alert_page.dart';
import 'package:trade_diary/view/home/home_page.dart';
import 'package:trade_diary/view/home/setting_page.dart';
import 'package:trade_diary/view/onBoarding/start_page.dart';
import 'package:trade_diary/view/onBoarding/login_page.dart';

class PageRouter {
  static const _settingPage = "setting";
  static const _onBoardingPage = "onBoarding";
  static const _loginPage = "login";
  static const _alertPage = "alert";
  static const _mainPage = "/";
  static const _writePage = "write";
  static const _characterPage = "character";

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: _mainPage,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: _settingPage,
            builder: (context, state) => const SettingPage(),
          ),
          GoRoute(
              path: _alertPage, builder: (context, state) => const AlertPage()),
          GoRoute(
            path: _loginPage,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: _onBoardingPage,
            builder: (context, state) => const FirstPage(),
          ),
          GoRoute(
              path: 'read/:id',
              builder: (context, state) =>
                  ReadPage(id: state.pathParameters['id'])),
          GoRoute(
              path: _writePage, builder: (context, state) => const WritePage()),
          GoRoute(
              path: _characterPage,
              builder: (context, state) => const MyCharacter()),
        ],
      )
    ],
  );
}
