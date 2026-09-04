import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:trade_diary/config/env.dart';
import 'package:trade_diary/util/app_exception.dart';

final supabase = Supabase.instance.client;

class OauthViewModel {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<void>? _googleSignInInitialization;

  static Future<void> _initializeGoogleSignIn() {
    final iosClientId = EnvConfig.googleIosClientId;
    final webClientId = EnvConfig.googleWebClientId;

    if (Platform.isIOS && iosClientId.isEmpty) {
      throw AuthenticationException('iOS 구글 로그인 설정이 누락되었습니다');
    }
    if (Platform.isAndroid && webClientId.isEmpty) {
      throw AuthenticationException('Android 구글 로그인 설정이 누락되었습니다');
    }

    return _googleSignInInitialization ??= _googleSignIn.initialize(
      clientId: Platform.isIOS ? iosClientId : null,
      serverClientId: webClientId.isEmpty ? null : webClientId,
    );
  }

  Future<AuthResponse?> nativeGoogleLogin() async {
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        await _initializeGoogleSignIn();
        final googleUser = await _googleSignIn.authenticate();

        final googleAuth = googleUser.authentication;
        final idToken = googleAuth.idToken;

        if (idToken == null) {
          throw AuthenticationException('구글 로그인 인증에 실패했습니다');
        }

        // ignore: experimental_member_use
        return await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
        );
      } on GoogleSignInException catch (e) {
        if (e.code == GoogleSignInExceptionCode.canceled) {
          throw AuthenticationException('구글 로그인이 취소되었습니다', originalError: e);
        }
        throw AuthenticationException('구글 로그인 중 오류가 발생했습니다', originalError: e);
      } catch (e) {
        if (e is AuthenticationException) rethrow;
        throw AuthenticationException('구글 로그인 중 오류가 발생했습니다', originalError: e);
      }
    }
    return null;
  }

  Future<AuthResponse> signInWithApple() async {
    try {
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
        throw AuthenticationException('애플 로그인 인증에 실패했습니다');
      }

      // ignore: experimental_member_use
      return await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );
    } catch (e) {
      if (e is AuthenticationException) rethrow;
      throw AuthenticationException('애플 로그인 중 오류가 발생했습니다', originalError: e);
    }
  }

  Future<void> webGoogleLogin() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: EnvConfig.authCallbackUrl,
      );
    } catch (e) {
      throw AuthenticationException('구글 로그인 중 오류가 발생했습니다', originalError: e);
    }
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      throw AuthenticationException('로그아웃 중 오류가 발생했습니다', originalError: e);
    }
  }

  String getUserId() {
    final user = supabase.auth.currentUser;
    if (user == null) {
      throw AuthenticationException('로그인이 필요합니다');
    }
    return user.id;
  }

  Future<void> deleteAccount() async {
    try {
      final response = await http.get(
        Uri.parse(EnvConfig.deleteUserUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${supabase.auth.currentSession?.accessToken}',
        },
      );

      if (response.statusCode != 200) {
        throw NetworkException(
          '계정 삭제에 실패했습니다',
          code: response.statusCode.toString(),
          originalError: response.body,
        );
      }
    } catch (e) {
      if (e is AppException) rethrow;
      throw NetworkException('계정 삭제 중 오류가 발생했습니다', originalError: e);
    }
  }
}
