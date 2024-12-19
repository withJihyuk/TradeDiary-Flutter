import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/view/components/bottom_navigation_bar.dart';
import 'package:trade_diary/view/diary/diary_page.dart';
import 'package:trade_diary/view/login/login_page.dart';
import 'package:trade_diary/view/my/my_page.dart';
import 'package:trade_diary/view/splash/splash_page.dart';
import 'package:trade_diary/view/todo/todo_page.dart';
import 'package:trade_diary/view/write/write_page.dart';

class PageRouter {
  static const _splashPage = "/";
  static const _writePage = "/write";
  static const _loginPage = "/login";

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: _splashPage,
        builder: (context, state) => const SplashPage(),
        routes: [
          // GoRoute(
          //     path: 'read/:id',
          //     builder: (context, state) =>
          //         ReadPage(id: state.pathParameters['id']!)),
          GoRoute(
              path: _writePage, builder: (context, state) => const WritePage()),

          GoRoute(
              path: _loginPage, builder: (context, state) => const LoginPage()),
        ],
      ),
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) => BottomBar(child: child),
        routes: [
          GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomePage())),
          GoRoute(
              path: '/diary',
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  )),
          GoRoute(
              path: '/todo',
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: TodoPage(),
                  )),
          GoRoute(
              path: '/my',
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: MyPage(),
                  )),
        ],
      ),
    ],
  );
}
