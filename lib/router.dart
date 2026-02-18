import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/view/systemSetting/system_setting_page.dart';
import 'package:trade_diary/view/components/bottom_navigation_bar.dart';
import 'package:trade_diary/view/deleteId/delete_id_page.dart';
import 'package:trade_diary/view/diary/diary_page.dart';
import 'package:trade_diary/view/write/write_selecting_emotion.dart';
import 'package:trade_diary/view/diary/diary_view.dart';
import 'package:trade_diary/view/home/home_page.dart';
import 'package:trade_diary/view/login/login_page.dart';
import 'package:trade_diary/view/my/my_page.dart';
import 'package:trade_diary/view/nickname/nickname_page.dart';
import 'package:trade_diary/view/splash/splash_page.dart';
import 'package:trade_diary/view/write/write_page.dart';

class PageRouter {
  static const _splashPage = "/";
  static const _writePage = "/write";
  static const _selectEmotionPage = "/select";
  static const _loginPage = "/login";
  static const _nicknamePage = "/nickname";
  static const _systemSettingPage = "/systemSetting";
  static const _deleteIdPage = "/deleteId";
  static const _readPage = "/read/:id";
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: _splashPage,
        builder: (context, state) => const SplashPage(),
        routes: [
          GoRoute(
            path: _readPage,
            builder: (context, state) {
              List<DiaryPostModel> posts = [];
              if (state.extra != null && state.extra is List<DiaryPostModel>) {
                posts = state.extra as List<DiaryPostModel>;
              }
              int day = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
              return DiaryView(posts: posts, day: day);
            },
          ),
          GoRoute(
              path: _writePage, builder: (context, state) => const WritePage()),
          GoRoute(
              path: _swipeGameGuidePage1,
              builder: (context, state) => const SwipeGameGuide1()),
          GoRoute(
              path: _swipeGameGuidePage2,
              builder: (context, state) => const SwipeGameGuide2()),
          GoRoute(
              path: _swipeGameGuidePage3,
              builder: (context, state) => const SwipeGameGuide3()),
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
              path: _selectEmotionPage,
              builder: (context, state) => const WriteSelectingEmotion()),
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
              path: '/my',
              pageBuilder: (context, state) => const NoTransitionPage(
                    child: MyPage(),
                  )),
        ],
      ),
    ],
  );
}
