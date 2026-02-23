import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart';

class QuillContentUtil {
  /// 저장된 content String → Quill Document 변환
  /// Delta JSON이면 Document.fromJson(), plain text(기존 데이터)면 Document()..insert(0, text)
  static Document contentToDocument(String content) {
    if (content.isEmpty) return Document();
    try {
      final decoded = jsonDecode(content);
      if (decoded is List) {
        return Document.fromJson(decoded);
      }
    } catch (_) {}
    return Document()..insert(0, content);
  }

  /// Quill Document → JSON String (DB 저장용)
  static String documentToContent(Document document) {
    return jsonEncode(document.toDelta().toJson());
  }

  /// 저장된 content String → plain text 추출
  /// 목록 미리보기, 검색 필터링에 사용
  static String contentToPlainText(String content) {
    if (content.isEmpty) return '';
    try {
      final decoded = jsonDecode(content);
      if (decoded is List) {
        return Document.fromJson(decoded).toPlainText().trim();
      }
    } catch (_) {}
    return content;
  }
}
