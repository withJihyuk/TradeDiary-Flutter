# 개발 에이전트 가이드

이 저장소에서는 기존 동작을 유지하는 최소 변경을 우선합니다. 임시 우회, 사용하지 않는 추상화, 요청하지 않은 테스트를 추가하지 않습니다.

## 도구 버전

- Flutter 3.47.2
- Dart 3.13 이상, 4.0 미만
- Ruby 3.3.1
- Fastlane 2.239.0
- iOS CI: Xcode 26.3

## 코드 구조

| 위치 | 역할과 탐색 시작점 |
| --- | --- |
| [main.dart](lib/main.dart), [router.dart](lib/router.dart) | 앱 초기화와 라우팅. 인증 이벤트에 따른 이동은 [NavigationService](lib/util/navigation_service.dart)도 확인합니다. |
| [view](lib/view/), [provider](lib/provider/) | 화면과 공유 상태. 화면 일부는 `part`/`part of`로 분리되어 있으므로 상위 페이지 파일부터 읽습니다. |
| [viewModel](lib/viewModel/), [dataSource](lib/dataSource/) | 작업 흐름과 데이터 접근. 일기·프로필은 Supabase를, 이미지 업로드는 별도 HTTP API를 사용합니다. |
| [supabase](supabase/README.md) | DB 마이그레이션과 회원 탈퇴 Edge Function. 앱 배포 전에 서버 계약을 먼저 적용합니다. |
| [model](lib/model/) | Freezed·JSON 직렬화 모델과 생성 파일. |
| [service](lib/service/), [util](lib/util/) | 알림·홈 위젯 연동과 본문 변환·날짜·감정·레벨 등의 기존 로직. |
| [designSystem](lib/designSystem/), [components](lib/view/components/) | 재사용할 색상·텍스트 스타일·테마와 공통 UI. |

화면·Provider·ViewModel·DataSource로 역할이 나뉘지만, 일부 Provider와 화면은 DataSource를 직접 호출합니다. 수정 전 실제 호출 경로를 확인합니다.

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

- 새 로직을 작성하기 전에 기존 호출부·유틸·공통 컴포넌트를 검색하고, 수정한 동작을 사용하는 다른 경로도 확인합니다.
- Freezed 또는 JSON 직렬화 모델을 변경했을 때만 `dart run build_runner build`를 실행합니다.
- 생성 파일(`*.freezed.dart`, `*.g.dart`)은 직접 수정하지 않습니다.
- 로컬 경로 의존성, 임시 패키지 override, 백업 파일을 커밋하지 않습니다.
- `.env`, 키스토어, 인증서, API 키와 비밀번호를 커밋하거나 로그에 출력하지 않습니다.
- 환경변수는 [lib/config/env.dart](lib/config/env.dart)에서 한 번에 읽고 검증합니다. 호출부마다 별도 예외를 추가하지 않습니다.
- 사용자가 명시적으로 요청하지 않으면 테스트를 추가하거나 확장하지 않습니다. 기존 테스트만 실행합니다.

## 변경 시 함께 확인할 사항

- **일기 본문과 이미지:** 본문은 Delta JSON 문자열로 저장하며 기존 일반 텍스트도 읽습니다. 변환은 [QuillContentUtil](lib/util/quill_content_util.dart)을 재사용하고, 이미지 변경 시 편집기의 로컬 경로부터 업로드·CDN URL 치환·읽기 화면까지 확인합니다.
- **임시저장과 완료 저장:** 일기 저장 변경 시 신규 작성·임시저장·이어쓰기·완료 전환 경로를 함께 확인합니다. 날짜 판정은 [날짜 유틸](lib/util/diary_post_date_util.dart)을 사용하고 완료일은 한국 시간 기준 서버 `diaryDate`를 따릅니다. 기기 저장 완료와 서버 동기화 완료를 구분하며, 충돌 시 미반영 내용을 새 초안으로 보존합니다.
- **목록과 상태 갱신:** [diaryListProvider](lib/provider/diary_list.dart)는 완료된 일기를, 같은 파일의 `paginatedDiaryProvider`는 완료된 일기의 검색·페이지 목록을 제공합니다. 초안은 [DraftStore](lib/service/draft_store.dart)의 사용자별 로컬 저장과 서버 동기화를 사용합니다. 완료 후 [완료 화면](lib/view/write/write_selecting_emotion.dart)에서 provider를 갱신하므로 목록·프로필·홈 위젯의 반영 경로를 함께 확인합니다.
- **모델과 실제 쓰기 데이터:** [일기 모델](lib/model/diary_post.dart)의 ID·임시저장 여부·생성/수정 시각은 기본 `toJson()`에서 제외됩니다. 모델이나 저장 필드 변경 시 [DataSource](lib/dataSource/diary_post.dart)에서 구성하는 쓰기 데이터도 확인합니다.
- **화면 이동:** `/write`와 `/select`는 `extra`로 임시저장 ID를 전달합니다. `/read/:id`는 일기 UUID를 사용하며 `extra` 없이도 조회합니다. `/drafts`는 임시저장 전용 목록입니다.
- **네이티브 홈 위젯:** [StreakService](lib/service/streak_service.dart)와 [Android](android/app/src/main/kotlin/com/jihyuk/potatodiary/PotatoDiaryWidget.kt)·[iOS](ios/PotatoDiaryWidget/PotatoDiaryWidget.swift)의 구현을 함께 확인합니다. 공유 데이터 키, App Group, 위젯에서 앱으로 진입하는 경로의 연결을 확인합니다.
- **서버 구현의 경계:** [서버 변경 안내](supabase/README.md)의 적용 순서와 RPC 계약을 확인합니다. 이미지 업로드는 별도 [supabase_upload_image](https://github.com/withJihyuk/supabase_upload_image) 저장소입니다. 신규 앱에는 서버 변경을 먼저 배포해야 하며 실제 운영 반영 여부는 별도로 확인합니다.

## 변경 검증

변경 범위에 해당하는 검증만 실행합니다.

| 변경 범위 | 검증 기준 |
| --- | --- |
| 문서만 변경 | `git diff --check`와 참조 경로·내용 확인 |
| Dart 코드 | 포맷 검사·정적 분석·기존 테스트 |
| 모델 | 코드 생성 후 생성 파일 차이 검토 및 Dart 검증 |
| 플랫폼·플러그인·빌드 설정 | 영향받는 Android/iOS 빌드 추가 |
| CI·배포 설정 | 변경한 파일에 해당하는 actionlint·셸 문법·Bundler/Fastlane 확인 |

CI는 모델 코드를 재생성하고 커밋된 생성 파일과 차이가 없는지도 검사합니다.

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
