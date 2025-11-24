import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  const EnvConfig._();

  static String get dbUrl => dotenv.env['DB_URL'] ?? '';
  static String get dbKey => dotenv.env['DB_KEY'] ?? '';
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static String get cdnUrl => dotenv.env['CDN_URL'] ?? '';
  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';

  static bool get isProduction => const bool.fromEnvironment('dart.vm.product');

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
  }

  static void validateConfig() {
    assert(dbUrl.isNotEmpty, 'DB_URL is not configured in .env file');
    assert(dbKey.isNotEmpty, 'DB_KEY is not configured in .env file');
    assert(apiUrl.isNotEmpty, 'API_URL is not configured in .env file');
    assert(cdnUrl.isNotEmpty, 'CDN_URL is not configured in .env file');
    if (isProduction) {
      assert(sentryDsn.isNotEmpty, 'SENTRY_DSN is not configured in .env file');
    }
  }
}
