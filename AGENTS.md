# 개발 에이전트 가이드

이 저장소에서는 기존 동작을 유지하는 최소 변경을 우선합니다. 임시 우회, 사용하지 않는 추상화, 요청하지 않은 테스트를 추가하지 않습니다.

## 도구 버전

- Flutter 3.47.2
- Dart 3.13 이상, 4.0 미만
- Ruby 3.3.1
- Fastlane 2.239.0
- iOS CI: Xcode 26.3

## 초기 설정

```sh
cp .env.example .env
flutter pub get
bundle install
```

Fastlane은 항상 Bundler를 통해 실행합니다.

```sh
bundle exec fastlane lanes
```

## 개발 원칙

- Freezed 또는 JSON 직렬화 모델을 변경했을 때만 `dart run build_runner build`를 실행합니다.
- 생성 파일(`*.freezed.dart`, `*.g.dart`)은 직접 수정하지 않습니다.
- 로컬 경로 의존성, 임시 패키지 override, 백업 파일을 커밋하지 않습니다.
- `.env`, 키스토어, 인증서, API 키와 비밀번호를 커밋하거나 로그에 출력하지 않습니다.
- 환경변수는 `env.dart`에서 한 번에 읽고 검증합니다. 호출부마다 별도 예외를 추가하지 않습니다.
- 사용자가 명시적으로 요청하지 않으면 테스트를 추가하거나 확장하지 않습니다. 기존 테스트만 실행합니다.

## 변경 검증

변경 범위에 맞게 아래 명령을 실행합니다.

```sh
git diff --check
dart format --output=none --set-exit-if-changed lib test
flutter analyze --no-pub
flutter test --no-pub
flutter build apk --debug --no-pub
DEVELOPER_DIR=/Applications/Xcode_26.3.app/Contents/Developer flutter build ios --simulator --no-pub
actionlint
bash -n .github/scripts/create-env.sh
bundle check
bundle exec fastlane lanes
```

## 브랜치와 릴리즈

- 일반 작업은 `develop`에서 분기하고 PR로 `develop`에 병합합니다.
- 스토어 릴리즈는 `develop`에서 `master`로 보내는 PR로만 진행합니다.
- `master` 릴리즈에서는 `pubspec.yaml`의 버전명과 빌드 번호를 모두 올리고 `fastlane/metadata/ko/release_notes.txt`도 수정해야 합니다.
- 빌드 번호는 저장소의 직전 값과 각 스토어의 현재 최고 값을 모두 초과해야 합니다.
- 병합 전 Android `verify`와 iOS `verify-ios`가 모두 성공했는지 확인합니다.
- 과거 실패 실행을 재실행하면 당시 SHA와 워크플로가 다시 사용됩니다. 워크플로 수정 후에는 새 커밋으로 새 릴리즈를 만듭니다.

### 프로덕션 Secret 이름

- 공통: `DB_URL`, `DB_KEY`, `API_URL`, `CDN_URL`, `SENTRY_DSN`, `GOOGLE_WEB_CLIENT_ID`, `GOOGLE_IOS_CLIENT_ID`
- Android: `ANDROID_KEYSTORE_BASE64`, `ANDROID_STORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
- iOS: `APP_STORE_CONNECT_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_KEY_BASE64`, `MATCH_PASSWORD`, `MATCH_GIT_PRIVATE_KEY`

값은 문서, 커밋, PR, 로그에 남기지 않습니다.

### Fastlane 동작

- Android `submit`은 CI에서 미리 서명한 AAB를 Google Play `production` 트랙에 `completed` 상태로 올립니다. 단계적 출시가 아니라 전체 출시입니다.
- iOS `submit`은 `setup_ci`, 읽기 전용 `match`, Xcode 26.3을 사용해 빌드하고 심사에 제출합니다. 자동 출시와 단계적 출시는 꺼져 있어 승인 후 수동 출시합니다.
- 로컬이나 `master`가 아닌 브랜치에서 `submit` lane을 실행하지 않습니다.

## 문제 해결

- Google Play가 업로드 키 불일치를 보고하면 Play Console의 활성 업로드 인증서 SHA-1과 빌드 AAB의 서명 인증서 SHA-1을 비교합니다. 원인 확인 없이 새 키를 다시 만들지 않습니다.
- iOS SDK 버전 오류가 나면 `DEVELOPER_DIR`와 `xcodebuild -version`을 먼저 확인합니다.
