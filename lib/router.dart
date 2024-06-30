import 'package:go_router/go_router.dart';
import 'package:trade_diary/view/home/home_page.dart';
import 'package:trade_diary/view/onBoarding/register.dart';
import 'package:trade_diary/view/setting/setting_page.dart';
import 'package:trade_diary/view/onBoarding/start_page.dart';
import 'package:trade_diary/view/onBoarding/login_page.dart';

class PageRouter {
  static const _homePage = "/";
  static const _settingPage = "sub";
  static const _onBoardingPage = "onBoarding";
  static const _loginPage = "login";
  static const _registerPage = "register";

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
          ),
          GoRoute(
            path: _onBoardingPage,
            builder: (context, state) => const FirstPage(),
          ),
          GoRoute(
            path: _loginPage,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: _registerPage,
            builder: (context, state) => const RegisterPage(),
          )
        ],
      )
    ],
  );
}
