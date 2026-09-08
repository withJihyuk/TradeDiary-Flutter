import 'dart:convert';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/config/env.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class DiaryPostDataSource {
  final supabase = Supabase.instance.client;
  static const timeout = Duration(seconds: 30);

  Future<List<DiaryPostModel>> getDiary() async {
    // Fetch every page: neither widget streaks nor historical dates may be truncated.
    final result = <DiaryPostModel>[];
    while (true) {
      final page = await getDiaryPaginated(
        page: result.length ~/ 100,
        pageSize: 100,
      );
      result.addAll(page);
      if (page.length < 100) return result;
    }
  }

  Future<List<DiaryPostModel>> getDrafts() async {
    final rows = <DiaryPostModel>[];
    while (true) {
      final page = await supabase
          .from('diary')
          .select()
          .eq('isDraft', true)
          .order('updatedAt', ascending: false)
          .order('id')
          .range(rows.length, rows.length + 99)
          .timeout(timeout);
      rows.addAll(page.map(DiaryPostModel.fromJson));
      if (page.length < 100) return rows;
    }
  }

  Future<DiaryPostModel?> getById(String id) async {
    final row = await supabase
        .from('diary')
        .select()
        .eq('id', id)
        .maybeSingle()
        .timeout(timeout);
    return row == null ? null : DiaryPostModel.fromJson(row);
  }

  Future<Map<String, dynamic>> mutate(
    String action,
    DiaryPostModel diary,
    String mutationId,
  ) async {
    final response = await supabase
        .rpc(
          action,
          params: {
            'p_id': diary.id,
            'p_revision': diary.revision,
            'p_mutation_id': mutationId,
            if (action != 'delete_draft') ...{
              'p_subject': diary.subject,
              'p_content': diary.content,
              'p_emotion': diary.emotion,
            },
          },
        )
        .timeout(timeout);
    return Map<String, dynamic>.from(response as Map);
  }

  Future<List<DiaryPostModel>> getDiaryPaginated({
    int page = 0,
    int pageSize = 20,
    String? query,
  }) async {
    final response = await supabase
        .rpc(
          'search_diaries',
          params: {
            'p_query': query ?? '',
            'p_offset': page * pageSize,
            'p_limit': pageSize,
          },
        )
        .timeout(timeout);
    return (response as List)
        .map((row) => DiaryPostModel.fromJson(Map<String, dynamic>.from(row)))
        .toList();
  }

  Future<List<String>> uploadImage(List<String> paths) async {
    if (paths.isEmpty) return [];
    if (paths.length > 10) throw NetworkException('사진은 최대 10장까지 추가할 수 있어요');
    final token = supabase.auth.currentSession?.accessToken;
    if (token == null) throw const AuthException('로그인이 필요합니다');
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${EnvConfig.apiUrl}/image'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    final ids = <String>[];
    for (final path in paths) {
      final bytes = await File(path).readAsBytes();
      if (bytes.length > 16 * 1024 * 1024) {
        throw NetworkException('사진 한 장의 크기는 16MB 이하여야 해요');
      }
      final mime = imageMime(bytes);
      final id = path.split('/').last.split('.').first;
      ids.add(id);
      request.files.add(
        http.MultipartFile.fromBytes(
          'files',
          bytes,
          filename: '$id.${mime.split('/').last}',
          contentType: MediaType.parse(mime),
        ),
      );
    }
    request.fields['imageIds'] = jsonEncode(ids);
    final client = http.Client();
    try {
      final response = await client
          .send(request)
          .timeout(const Duration(seconds: 60));
      final body = await response.stream.bytesToString().timeout(
        const Duration(seconds: 60),
      );
      if (response.statusCode != 200) {
        throw NetworkException('사진을 동기화하지 못했어요. 다시 시도해 주세요');
      }
      final values = jsonDecode(body);
      if (values is! List ||
          values.length != ids.length ||
          List.generate(
            ids.length,
            (i) => values[i] == ids[i],
          ).contains(false)) {
        throw NetworkException('사진 저장 응답을 확인하지 못했어요');
      }
      return ids.map((id) => '${EnvConfig.cdnUrl}/$id').toList();
    } finally {
      client.close();
    }
  }

  static String imageMime(List<int> b) {
    if (b.length >= 12 &&
        ascii.decode(b.sublist(0, 4), allowInvalid: true) == 'RIFF' &&
        ascii.decode(b.sublist(8, 12), allowInvalid: true) == 'WEBP') {
      return 'image/webp';
    }
    if (b.length >= 3 && b[0] == 255 && b[1] == 216 && b[2] == 255) {
      return 'image/jpeg';
    }
    if (b.length >= 8 && b.take(8).join(',') == '137,80,78,71,13,10,26,10') {
      return 'image/png';
    }
    throw NetworkException('지원하지 않는 사진 형식이에요');
  }
}
