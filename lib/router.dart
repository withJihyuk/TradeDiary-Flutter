import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/view/components/bottom_navigation_bar.dart';
import 'package:trade_diary/view/diary/read_page.dart';
import 'package:trade_diary/view/diary/write_page.dart';
import 'package:trade_diary/view/home/home_page.dart';
import 'package:trade_diary/view/splash/splash_page.dart';

class PageRouter {
  static const _splashPage = "/";
  static const _writePage = "write";

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: _splashPage,
        builder: (context, state) => const SplashPage(),
        routes: const [
          // GoRoute(
          //     path: 'read/:id',
          //     builder: (context, state) =>
          //         ReadPage(id: state.pathParameters['id']!)),
          // GoRoute(
          //     path: _writePage, builder: (context, state) => const WritePage()),
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
                    child: HomePage(),
                  )),
          GoRoute(
              path: '/my',
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  )),
        ],
      ),
    ],
  );
}
