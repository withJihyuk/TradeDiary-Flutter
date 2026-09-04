import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  const EnvConfig._();

  static String get dbUrl => dotenv.env['DB_URL'] ?? '';
  static String get dbKey => dotenv.env['DB_KEY'] ?? '';
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static String get cdnUrl => dotenv.env['CDN_URL'] ?? '';
  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';
  static String get googleWebClientId =>
      dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
  static String get googleIosClientId =>
      dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? '';
  static String get authCallbackUrl => '$dbUrl/auth/v1/callback';
  static String get deleteUserUrl => '$dbUrl/functions/v1/delete-user';

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }
}
