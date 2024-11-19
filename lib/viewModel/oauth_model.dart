import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final supabase = Supabase.instance.client;

class OauthViewModel {
  Future nativeGoogleLogin() async {
    if (Platform.isAndroid || Platform.isIOS) {
      const webClientId =
          '758208968172-95ov64v7jpu6vfopo0ho3hnfnn72ktri.apps.googleusercontent.com';
      const iosClientId =
          '758208968172-8q68eo2oh2j2v6b7hklu35qb6rgophik.apps.googleusercontent.com';
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );
      try {
        final googleUser = await googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        final accessToken = googleAuth.accessToken;
        final idToken = googleAuth.idToken;

        if (accessToken == null || idToken == null) {
          throw Exception('로그인에 문제가 발생했어요! 다시 시도해주세요.');
        }

        return supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );
      } catch (e) {
        return null;
      }
    }
  }

  webGoogleLogin() {
    supabase.auth.signInWithOAuth(
      OAuthProvider.google,
    );
  }

  // appleLogin() {
  //   if (Platform.isIOS) {
  //     supabase.auth.signInWithOAuth(
  //       OAuthProvider.apple,
  //       redirectTo: dotenv.env['REDIRECT_URI']!,
  //     );
  //   }
  // }

  logout() {
    supabase.auth.signOut();
  }

  getUserId() {
    return supabase.auth.currentUser!.id;
  }
}

