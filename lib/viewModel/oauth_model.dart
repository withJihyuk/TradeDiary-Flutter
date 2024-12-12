import 'dart:convert';
import 'dart:io';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:crypto/crypto.dart';

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

  Future<AuthResponse> signInWithApple() async {
    final rawNonce = supabase.auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
          'Could not find ID Token from generated credential.');
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  webGoogleLogin() {
    supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'https://flhaiiwtaqnmczabiojs.supabase.co/auth/v1/callback'
    );
  }

  logout() {
    supabase.auth.signOut();
  }

  getUserId() {
    return supabase.auth.currentUser!.id;
  }
}

