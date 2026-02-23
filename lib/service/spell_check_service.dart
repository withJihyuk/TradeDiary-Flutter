/// 부산대 맞춤법 검사기 연동 서비스
/// TODO: API 엔드포인트 및 인증 방식 확인 후 구현
///
/// 사용 예시 (구현 후):
/// ```dart
/// final results = await SpellCheckService.check('안녕하세여');
/// for (final r in results) {
///   print('${r.original} → ${r.suggestions.join(", ")}');
/// }
/// ```
///
/// 에디터 연동 계획:
/// 1. 툴바에 "맞춤법 검사" 버튼 추가
/// 2. 버튼 탭 → 현재 문서 plain text로 API 호출
/// 3. 결과를 에디터에 밑줄(빨간)로 표시
/// 4. 밑줄 탭 → 교정 제안 팝업
class SpellCheckService {
  // ignore: unused_field
  static const String _apiUrl = 'http://speller.cs.pusan.ac.kr/api';

  /// 맞춤법 검사 요청
  /// [text] 검사할 텍스트
  /// 반환: SpellCheckResult 리스트 (오류 위치, 교정 제안)
  static Future<List<SpellCheckResult>> check(String text) async {
    // TODO: 부산대 API 연동
    // 1. POST 요청 (text 파라미터)
    //    - Content-Type: application/x-www-form-urlencoded
    //    - Body: text=검사할+한국어+문장
    // 2. 응답 파싱 (errorIdx, errorMsg, candWord 등)
    //    - 응답 형식 예시:
    //    {
    //      "result": {
    //        "errors": [
    //          {
    //            "errorIdx": 0,
    //            "errorMsg": "맞춤법/문법 오류",
    //            "startIdx": 2,
    //            "endIdx": 3,
    //            "candWord": ["올바른", "단어"],
    //            "priority": 1
    //          }
    //        ]
    //      }
    //    }
    // 3. SpellCheckResult로 변환
    throw UnimplementedError('맞춤법 검사 API 연동 필요');
  }
}

class SpellCheckResult {
  final int startIndex;
  final int endIndex;
  final String original;
  final List<String> suggestions;
  final String message;

  const SpellCheckResult({
    required this.startIndex,
    required this.endIndex,
    required this.original,
    required this.suggestions,
    required this.message,
  });
}
