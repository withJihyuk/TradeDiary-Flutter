import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OauthProvider {
  final Platform platform;
  final String provider;

  const OauthProvider({required this.platform, required this.provider});

  static googleLogin() {
    final supabase = Supabase.instance.client;
    if (kIsWeb) {
      supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: dotenv.env['REDIRECT_URI']!,
      );
    }
    if (Platform.isAndroid || Platform.isIOS) {
      Future<AuthResponse> nativeLogin() async {
        const webClientId =
            '758208968172-95ov64v7jpu6vfopo0ho3hnfnn72ktri.apps.googleusercontent.com';
        const iosClientId =
            '758208968172-s02f95mh5sv31cb23tqa36uh1n2uj4rb.apps.googleusercontent.com';
        final GoogleSignIn googleSignIn = GoogleSignIn(
          clientId: iosClientId,
          serverClientId: webClientId,
        );
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

        return supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );
      }
    }
  }

  static appleLogin() {
    final supabase = Supabase.instance.client;
    if (Platform.isIOS) {
      supabase.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: dotenv.env['REDIRECT_URI']!,
      );
    }
  }
}
