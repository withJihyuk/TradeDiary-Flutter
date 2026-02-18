import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/navigation_service.dart';
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
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    redirect: (context, state) {
      final location = state.matchedLocation;
      final session = Supabase.instance.client.auth.currentSession;
      final loggedIn = session != null;

      // 스플래시에서만 리다이렉트
      if (location == '/') {
        if (!loggedIn) return '/login';
        if (NavigationService.pendingWidgetRoute != null) {
          final route = NavigationService.pendingWidgetRoute!;
          NavigationService.pendingWidgetRoute = null;
          return route;
        }
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/write',
        builder: (context, state) => const WritePage(),
      ),
      GoRoute(
        path: '/select',
        builder: (context, state) => const WriteSelectingEmotion(),
      ),
      GoRoute(
        path: '/nickname',
        builder: (context, state) => const NicknamePage(),
      ),
      GoRoute(
        path: '/systemSetting',
        builder: (context, state) => const SystemSettingPage(),
      ),
      GoRoute(
        path: '/deleteId',
        builder: (context, state) => const DeleteIdPage(),
      ),
      GoRoute(
        path: '/read/:id',
        builder: (context, state) {
          List<DiaryPostModel> posts = [];
          if (state.extra != null && state.extra is List<DiaryPostModel>) {
            posts = state.extra as List<DiaryPostModel>;
          }
          int day = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return DiaryView(posts: posts, day: day);
        },
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
