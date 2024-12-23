import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/systemSetting/system_setting_page.dart';
import 'package:trade_diary/view/components/bottom_navigation_bar.dart';
import 'package:trade_diary/view/deleteId/delete_id_page.dart';
import 'package:trade_diary/view/diary/diary_page.dart';
import 'package:trade_diary/view/diary/diary_selecting_emotion.dart';
import 'package:trade_diary/view/home/home_page.dart';
import 'package:trade_diary/view/login/login_page.dart';
import 'package:trade_diary/view/my/my_page.dart';
import 'package:trade_diary/view/nickname/nickname_page.dart';
import 'package:trade_diary/view/splash/splash_page.dart';
import 'package:trade_diary/view/todo/todo_add.dart';
import 'package:trade_diary/view/todo/todo_page.dart';
import 'package:trade_diary/view/write/write_page.dart';

class PageRouter {
  static const _splashPage = "/";
  static const _writePage = "/write";
  static const _todoAddPage = "/add";
  static const _selectEmotionPage = "/select";
  static const _loginPage = "/login";
  static const _nicknamePage = "/nickname";
  static const _systemSettingPage = "/systemSetting";
  static const _deleteIdPage = "/deleteId";

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
              path: _deleteIdPage,
              builder: (context, state) => const DeleteIdPage()),
          GoRoute(
              path: _systemSettingPage,
              builder: (context, state) => const SystemSettingPage()),
          GoRoute(
              path: _nicknamePage,
              builder: (context, state) => const NicknamePage()),
          GoRoute(
              path: _todoAddPage,
              builder: (context, state) => const TodoAddPage()),
          GoRoute(
              path: _selectEmotionPage,
              builder: (context, state) => const DiarySelectingEmotion()),

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
                    child: DiaryPage(),
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
