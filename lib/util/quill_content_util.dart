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

  /// Document Delta에서 로컬 이미지 파일 경로만 추출
  static List<String> extractLocalImagePaths(Document document) {
    final paths = <String>[];
    for (final op in document.toDelta().toList()) {
      if (op.isInsert && op.value is Map) {
        final map = op.value as Map;
        if (map.containsKey('image')) {
          final url = map['image'] as String;
          if (!url.startsWith('http://') && !url.startsWith('https://')) {
            paths.add(url);
          }
        }
      }
    }
    return paths;
  }

  /// Document Delta에서 로컬 이미지 경로를 CDN URL로 치환한 JSON 반환
  static String replaceImagePaths(
    Document document,
    List<String> localPaths,
    List<String> cdnUrls,
  ) {
    final deltaJson = document.toDelta().toJson();
    final jsonList = jsonDecode(jsonEncode(deltaJson)) as List;
    for (final op in jsonList) {
      if (op is Map && op['insert'] is Map) {
        final insert = op['insert'] as Map;
        if (insert.containsKey('image')) {
          final idx = localPaths.indexOf(insert['image'] as String);
          if (idx != -1) {
            insert['image'] = cdnUrls[idx];
          }
        }
      }
    }
    return jsonEncode(jsonList);
  }
}
