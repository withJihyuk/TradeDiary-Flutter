import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/service/streak_service.dart';

class NavigationService {
  static String? pendingWidgetRoute;
  static bool isWidgetWriteUri(Uri? uri) =>
      uri != null &&
      ['potatodiary', 'tradediary'].contains(uri.scheme.toLowerCase()) &&
      (uri.host.toLowerCase() == 'write' || uri.path == '/write');
  static StreamSubscription<AuthState> handleAuthStateChange(
    BuildContext context,
    void Function(String?) onUserChanged,
  ) {
    final auth = Supabase.instance.client.auth;
    String? previous = auth.currentUser?.id;
    return auth.onAuthStateChange.listen((data) {
      final current = data.session?.user.id;
      if (current == previous) return;
      previous = current;
      onUserChanged(current);
      unawaited(StreakService.clearWidgetData());
      if (!context.mounted) return;
      if (current == null) {
        PageRouter.router.go('/login');
      } else {
        final route = pendingWidgetRoute ?? '/home';
        pendingWidgetRoute = null;
        PageRouter.router.go(route);
      }
    });
  }
}
