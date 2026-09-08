import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trade_diary/util/app_exception.dart';

class EnvConfig {
  const EnvConfig._();

  static const _requiredKeys = [
    'DB_URL',
    'DB_KEY',
    'API_URL',
    'CDN_URL',
    'SENTRY_DSN',
    'GOOGLE_WEB_CLIENT_ID',
    'GOOGLE_IOS_CLIENT_ID',
  ];

  static String get dbUrl => dotenv.get('DB_URL');
  static String get dbKey => dotenv.get('DB_KEY');
  static String get apiUrl => dotenv.get('API_URL');
  static String get cdnUrl => dotenv.get('CDN_URL');
  static String get sentryDsn => dotenv.get('SENTRY_DSN');
  static String get googleWebClientId => dotenv.get('GOOGLE_WEB_CLIENT_ID');
  static String get googleIosClientId => dotenv.get('GOOGLE_IOS_CLIENT_ID');
  static String get authCallbackUrl => '$dbUrl/auth/v1/callback';
  static String get deleteUserUrl => '$dbUrl/functions/v1/delete-user';

  /// Loads and validates all application environment variables at startup.
  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');

    final environment = dotenv.env;
    final missingKeys = _requiredKeys
        .where((key) => environment[key]?.trim().isEmpty ?? true)
        .toList();
    if (missingKeys.isNotEmpty) {
      throw ValidationException('필수 환경변수가 누락되었습니다: ${missingKeys.join(', ')}');
    }
  }
}
