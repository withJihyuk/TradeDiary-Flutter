import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/config/env.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/app_exception.dart';
import 'package:trade_diary/util/image_compressor.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class DiaryPostDataSource {
  final supabase = Supabase.instance.client;

  Future<void> createDiaryPost(DiaryPostModel data) async {
    try {
      await supabase.from("diary").insert(data.toJson());
    } catch (e) {
      throw DatabaseException('글을 작성하는데 실패했어요', originalError: e);
    }
  }

  Future<List<DiaryPostModel>> getDiary() async {
    try {
      final response = await supabase.from("diary").select();
      return response
          .map((item) => DiaryPostModel.fromJson(item))
          .where((d) => !d.isDraft)
          .toList();
    } catch (e) {
      throw DatabaseException('글을 가져오는데 실패했어요', originalError: e);
    }
  }

  /// 드래프트 저장 (upsert). 반환값은 드래프트 ID.
  Future<String> upsertDraft(DiaryPostModel data) async {
    try {
      final json = data.toJson();
      json['isDraft'] = true;
      json['updatedAt'] = DateTime.now().toIso8601String();

      if (data.id != null) {
        await supabase.from("diary").update(json).eq('id', data.id!);
        return data.id!;
      } else {
        final response =
            await supabase.from("diary").insert(json).select('id').single();
        return response['id'] as String;
      }
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('임시저장에 실패했어요', originalError: e);
    }
  }

  /// 드래프트를 완성된 일기로 전환
  Future<void> finalizeDraft(String id, DiaryPostModel data) async {
    try {
      final json = data.toJson();
      json['isDraft'] = false;
      json['updatedAt'] = DateTime.now().toIso8601String();
      json.remove('id');
      json.remove('createdAt');
      await supabase.from("diary").update(json).eq('id', id);
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('일기 저장에 실패했어요', originalError: e);
    }
  }

  /// 사용자의 최신 드래프트 1개 조회 (없으면 null)
  Future<DiaryPostModel?> getLatestDraft() async {
    try {
      final response = await supabase
          .from("diary")
          .select()
          .eq('isDraft', true)
          .order('updatedAt', ascending: false)
          .limit(1)
          .maybeSingle();
      if (response == null) return null;
      return DiaryPostModel.fromJson(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('임시저장 조회에 실패했어요', originalError: e);
    }
  }

  /// 특정 드래프트 조회
  Future<DiaryPostModel?> getDraftById(String id) async {
    try {
      final response =
          await supabase.from("diary").select().eq('id', id).maybeSingle();
      if (response == null) return null;
      return DiaryPostModel.fromJson(response);
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('임시저장 글을 불러오지 못했어요', originalError: e);
    }
  }

  /// 드래프트 삭제
  Future<void> deleteDraft(String id) async {
    try {
      await supabase.from("diary").delete().eq('id', id).select();
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('임시저장 글을 삭제하지 못했어요', originalError: e);
    }
  }

  /// 페이지네이션 + 서버 검색
  Future<List<DiaryPostModel>> getDiaryPaginated({
    int page = 0,
    int pageSize = 20,
    String? query,
  }) async {
    try {
      var request = supabase.from("diary").select();

      if (query != null && query.isNotEmpty) {
        request = request.or('subject.ilike.%$query%,content.ilike.%$query%');
      }

      final from = page * pageSize;
      final to = from + pageSize - 1;
      final response =
          await request.order('date', ascending: false).range(from, to);
      return response.map((item) => DiaryPostModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException('글을 가져오는데 실패했어요', originalError: e);
    }
  }

  Future<List<String>> uploadImage(List<String> imagePaths) async {
    try {
      final apiUrl = "${EnvConfig.apiUrl}/image";

      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
      final token = supabase.auth.currentSession?.accessToken;

      if (token == null) {
        throw const AuthException('로그인이 필요합니다');
      }

      request.headers['Authorization'] = "Bearer $token";

      for (var path in imagePaths) {
        final compressed = await ImageCompressor.compressToWebP(path);
        if (compressed != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'files',
              compressed,
              filename: '${DateTime.now().millisecondsSinceEpoch}.webp',
              contentType: MediaType('image', 'webp'),
            ),
          );
        } else {
          final extension = path.split('.').last.toLowerCase();
          final mimeType = extension == 'jpg' ? 'jpeg' : extension;
          request.files.add(
            await http.MultipartFile.fromPath(
              'files',
              path,
              contentType: MediaType('image', mimeType),
            ),
          );
        }
      }

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw NetworkException(
          '이미지 업로드에 실패했어요',
          code: response.statusCode.toString(),
          originalError: responseData,
        );
      }

      List<dynamic> jsonResponse = json.decode(responseData);
      return jsonResponse
          .map<String>((uuid) => "${EnvConfig.cdnUrl}/$uuid")
          .toList();
    } catch (e) {
      if (e is AppException) rethrow;
      throw NetworkException('이미지 업로드 중 오류가 발생했어요', originalError: e);
    }
  }
}
