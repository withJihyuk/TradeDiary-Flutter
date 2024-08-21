import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trade_diary/main.dart';
import 'package:go_router/go_router.dart';

final supabase = Supabase.instance.client;

class OauthViewModel {
  Future<AuthResponse?> nativeGoogleLogin() async {
    if (Platform.isAndroid || Platform.isIOS) {
      const webClientId =
          '758208968172-95ov64v7jpu6vfopo0ho3hnfnn72ktri.apps.googleusercontent.com';
      const iosClientId =
          '758208968172-s02f95mh5sv31cb23tqa36uh1n2uj4rb.apps.googleusercontent.com';
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      try {
        final googleUser = await googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        final accessToken = googleAuth.accessToken;
        final idToken = googleAuth.idToken;

        if (accessToken == null) {
          throw 'No Access Token found.';
        }
        if (idToken == null) {
          throw 'No ID Token found.';
        }

        prefs.setBool('onboardingCompleteKey', true);

        return supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,

          // 페이지 이동 필요
        );
      } catch (e) {
        print(e);
        // 에러 리포트 발송 필요
      }
    }
    return null;
  }

  webGoogleLogin() {
    supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: dotenv.env['REDIRECT_URI']!,
    );
  }

  appleLogin() {
    if (Platform.isIOS) {
      supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: dotenv.env['REDIRECT_URI']!,
      );
    }
  }

  checkUserLogin() {
    if (supabase.auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  logout() {
    supabase.auth.signOut();
    prefs.setBool('onboardingCompleteKey', false);
  }

  static void navigationByState(BuildContext context) {
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;

      switch (event) {
        case AuthChangeEvent.signedIn:
          print("로그인 성공");
          context.push("/home");
        case AuthChangeEvent.signedOut:
          context.push("/onBoarding");
        case AuthChangeEvent.tokenRefreshed:
          print("토큰 리프리싱 성공");
        case AuthChangeEvent.userDeleted:
          print("유저 삭제 성공");
        case _:
          print("기타 이벤트");
      }
    });
  }
}
