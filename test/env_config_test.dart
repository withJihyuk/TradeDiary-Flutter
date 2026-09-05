import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trade_diary/config/env.dart';
import 'package:trade_diary/util/app_exception.dart';

const _validEnvironment = '''
DB_URL=https://example.supabase.co
DB_KEY=test-key
API_URL=https://api.example.com
CDN_URL=https://cdn.example.com
SENTRY_DSN=https://sentry.example.com/1
GOOGLE_WEB_CLIENT_ID=web-client-id
GOOGLE_IOS_CLIENT_ID=ios-client-id
''';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late String environment;

  setUp(() {
    environment = _validEnvironment;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (message) async {
          final asset = utf8.decode(
            message!.buffer.asUint8List(
              message.offsetInBytes,
              message.lengthInBytes,
            ),
          );
          if (asset != '.env') return null;

          return ByteData.sublistView(
            Uint8List.fromList(utf8.encode(environment)),
          );
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', null);
    dotenv.clean();
  });

  test('reports all missing or blank values together', () async {
    environment = _validEnvironment
        .replaceFirst('DB_KEY=test-key', 'DB_KEY=   ')
        .replaceFirst('SENTRY_DSN=https://sentry.example.com/1\n', '');

    await expectLater(
      EnvConfig.initialize(),
      throwsA(
        isA<ValidationException>()
            .having((error) => error.message, 'message', contains('DB_KEY'))
            .having(
              (error) => error.message,
              'message',
              contains('SENTRY_DSN'),
            ),
      ),
    );
  });

  test('exposes loaded environment values and derived URLs', () {
    dotenv.loadFromString(envString: _validEnvironment);

    expect(EnvConfig.apiUrl, 'https://api.example.com');
    expect(
      EnvConfig.authCallbackUrl,
      'https://example.supabase.co/auth/v1/callback',
    );
    expect(
      EnvConfig.deleteUserUrl,
      'https://example.supabase.co/functions/v1/delete-user',
    );
  });
}
