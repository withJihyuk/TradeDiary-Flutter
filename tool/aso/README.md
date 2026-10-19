# 스토어 이미지 재생성

전용 iPhone 시뮬레이터와 Android 에뮬레이터에서 기존 앱 위젯을 로컬 예시 데이터로 실행한다. 운영 계정·환경변수·서버 데이터는 읽지 않는다. `lib/main.dart`, 앱 기능, 모델, 의존성은 변경하지 않는다. 촬영용 entrypoint를 스토어 빌드에 사용하지 않는다.

필요 환경: 저장소의 Flutter/Dart와 패키지, iOS Simulator/Xcode, Android SDK/adb, Python 3. 최종 PNG 인코딩과 모아보기 생성에는 macOS Swift/AppKit을 사용한다.

## 실행

아래의 `IOS_CAPTURE_UUID`·`ANDROID_CAPTURE_SERIAL`은 직접 만든 전용 촬영 기기의 ID로 바꾼다. 개인 데이터가 들어 있는 기기는 사용하지 않는다. Flutter 명령은 각각 터미널을 열어 실행하고 이미지 출력이 끝날 때까지 유지한다.

```sh
flutter run --debug --no-pub -d IOS_CAPTURE_UUID -t tool/aso/capture.dart
```

```sh
flutter run --debug --no-pub -d ANDROID_CAPTURE_SERIAL -t tool/aso/capture.dart
adb -s ANDROID_CAPTURE_SERIAL forward tcp:18765 tcp:8765
```

촬영 앱은 기기 내 `127.0.0.1:8765`에서 제어 요청을 받는다. iOS Simulator는 호스트의 같은 포트에서, Android는 위에서 전달한 `18765` 포트에서 접근한다. 실제 촬영 예시는 iPhone 17 Pro Max 1320×2868과 Android 1080×2400이며, Android의 최종 캔버스는 1080×1920이다.

## 실제 홈 위젯 준비

```sh
curl --fail http://127.0.0.1:8765/widget
curl --fail http://127.0.0.1:18765/widget
```

이 요청은 전용 촬영 기기의 네이티브 위젯 공유 저장소에 예시 데이터만 넣는다. 완료 일기 42편, EXP 42, LV.3, 현재 진행 8/23, 최근 7일 연속 기록으로 구성한다. iOS는 현재 주의 감정 달력만 표시하며 Android와 표시 항목이 다르다. 날짜는 촬영 시점의 한국 날짜를 따른다.

- iOS: 홈 화면 편집 → 위젯 추가 → 감자일기 → 중간 크기 위젯을 추가한다.
- Android: 홈 화면에서 감자일기 위젯을 추가한다. 또는 `curl --fail http://127.0.0.1:18765/pin-widget`로 고정 대화상자를 열고 기기에서 확인한다. 넓이를 늘리면 실제 중형 레이아웃을 촬영할 수 있다.
- 편집 핸들·키보드·대화상자가 닫힌 실제 홈 화면을 저장한다. 원본은 `build/aso/ios-widget.png`, `build/aso/android-widget.png`처럼 저장소 밖으로 전달되지 않는 빌드 디렉터리에 둔다.

```sh
xcrun simctl io IOS_CAPTURE_UUID screenshot build/aso/ios-widget.png
adb -s ANDROID_CAPTURE_SERIAL exec-out screencap -p > build/aso/android-widget.png
```

홈 화면 촬영 후 앱을 다시 앞으로 가져와 제어 서버가 응답하는 상태에서 출력한다.

```sh
python3 tool/aso/export.py ios IOS_CAPTURE_UUID --widget build/aso/ios-widget.png
python3 tool/aso/export.py android ANDROID_CAPTURE_SERIAL --port 18765 --widget build/aso/android-widget.png
swift tool/aso/package.swift docs/aso/previews
```

기본 출력은 `docs/aso/previews/ios/`·`android/`의 각 6장이다. 사용자 요청에 따라 Google Play 그래픽 이미지 교체는 제외한다. 참고용 그래픽을 다시 만들 때만 Android 내보내기에 `--feature-graphic`을 지정한다. `package.swift`는 양쪽 플랫폼 PNG를 알파 없는 RGB로 인코딩하고 플랫폼별 모아보기 두 장을 만든다. `index.html`에서 원본 크기로 열어 검토한다. 모아보기·갤러리는 스토어 업로드 대상이 아니다.

## 구성·검수

- `capture.dart`: 기존 화면을 Provider override와 가상 프로필로 실행하고, 기기에서 촬영한 PNG에 기존 감자 자산·한글 헤드라인·프레임을 조합한다. 본문 이미지는 [생성 출처가 기록된 예시 사진](../../docs/aso/assets/README.md)을 사용한다.
- `export.py`: 기존 홈·감정 선택·일기 읽기·검색·임시저장·이어쓰기 화면을 촬영해 내보낸다. 원본 OS 화면은 `build/aso/raw/`에 보관한다.
- `package.swift`: 규격을 바꾸지 않고 RGB PNG 인코딩과 검토용 모아보기를 생성한다.
- 네이티브 위젯은 실제 OS 홈 화면의 원본을 입력받는다. Flutter로 흉내 낸 위젯을 사용하지 않는다.
- 이미지의 날짜·감정·성장 정보, 한글 글리프·줄바꿈, 기기 하단 잘림, 실제 화면과 장식의 겹침을 확인한다. 도구를 고친 경우 현재 Flutter 실행에서 hot restart 후 다시 출력한다.

앱을 구동하는 촬영 도구만 추가했으며 제품 테스트 파일은 추가하지 않는다. 스토어 게시와 자동 업로드는 [기존 적용 절차](../../docs/aso/README.md)를 따른다.

읽기 화면을 검수할 때 `/scene/plain`은 기존 일반 텍스트 예시를, `/scene/photo`는 사진·굵게·색 서식이 포함된 Delta 예시를 표시한다. 기기 글자 크기를 바꿔 확인한 뒤 스토어 촬영 전에는 기본 크기로 복원한다.
