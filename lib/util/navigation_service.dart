import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/router.dart';

class NavigationService {
  static void handleAuthStateChange(BuildContext context) {
    final supabase = Supabase.instance.client;
    supabase.auth.onAuthStateChange.listen(
      (data) async {
        final AuthChangeEvent event = data.event;

        try {
          if (context.mounted) {
            switch (event) {
              case AuthChangeEvent.initialSession:
                if (data.session != null) {
                  PageRouter.router.go("/home");
                } else {
                  PageRouter.router.go("/login");
                }
                break;

              case AuthChangeEvent.signedIn:
                PageRouter.router.go("/home");
                break;

              case AuthChangeEvent.signedOut:
                PageRouter.router.go("/login");
                break;

              default:
                break;
            }
          }
        } catch (e, stackTrace) {
          await Sentry.captureException(
            e,
            stackTrace: stackTrace,
            hint: Hint.withMap({
              'event': event.toString(),
              'context_mounted': context.mounted,
            }),
          );

          if (context.mounted) {
            PageRouter.router.go("/login");
          }
        }
      },
      onError: (error) async {
        await Sentry.captureException(
          error,
          hint: Hint.withMap({'error_source': 'auth_state_change_listener'}),
        );
      },
    );
  }
} 