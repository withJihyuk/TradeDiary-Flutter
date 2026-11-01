# 감자일기

일기를 쓰면 감자가 자라는 감정 일기 앱입니다. Flutter로 만들었고 Supabase를 서버로 사용합니다.

- [App Store](https://apps.apple.com/kr/app/감자일기/id6739600096)
- [Google Play](https://play.google.com/store/apps/details?id=com.jihyuk.potatodiary&hl=ko)

## 시작하기

```sh
cp .env.example .env
flutter pub get
bundle install
flutter run
```

도구 버전, 코드 구조, 검증 방법, 브랜치와 릴리즈 절차는 [개발 에이전트 가이드](AGENTS.md)를 따릅니다.

## 문서

- [서버 변경과 RPC 계약](supabase/README.md)
- [한국 스토어 ASO 등록·미리보기 제작안](docs/aso/README.md)
- [스토어 이미지 재생성](tool/aso/README.md)
- [신규 사용자 유입을 위한 시장 조사](docs/aso/market-research-2026-10.md)
