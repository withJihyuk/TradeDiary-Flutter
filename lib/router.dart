import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/navigation_service.dart';
import 'package:trade_diary/view/systemSetting/system_setting_page.dart';
import 'package:trade_diary/view/components/bottom_navigation_bar.dart';
import 'package:trade_diary/view/deleteId/delete_id_page.dart';
import 'package:trade_diary/view/diary/diary_page.dart';
import 'package:trade_diary/view/diary/draft_list_page.dart';
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

      if (!loggedIn && location != '/login' && location != '/') {
        if (location == '/write') {
          NavigationService.pendingWidgetRoute = '/write';
        }
        return '/login';
      }
      if (loggedIn && location == '/login') return '/home';
      if (location == '/select' && state.extra is! String) return '/write';
      // 초기 진입
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
      GoRoute(path: '/', builder: (context, state) => const SplashPage()),
      GoRoute(
        path: '/drafts',
        builder: (context, state) => const DraftListPage(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/write',
        builder: (context, state) {
          final draftId = state.extra as String?;
          return WritePage(draftId: draftId);
        },
      ),
      GoRoute(
        path: '/select',
        builder: (context, state) {
          final draftId = state.extra as String?;
          return WriteSelectingEmotion(draftId: draftId);
        },
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
          return DiaryView(
            id: state.pathParameters['id'] ?? '',
            initial: state.extra is DiaryPostModel
                ? state.extra as DiaryPostModel
                : null,
          );
        },
      ),
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) => BottomBar(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: '/diary',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DiaryPage()),
          ),
          GoRoute(
            path: '/my',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MyPage()),
          ),
        ],
      ),
    ],
  );
}
