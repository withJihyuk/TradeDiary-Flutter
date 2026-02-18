import 'package:flutter/material.dart';
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
      await supabase.from("diary").insert(data);
    } catch (e) {
      throw DatabaseException('글을 작성하는데 실패했어요', originalError: e);
    }
  }

  Future<List<DiaryPostModel>> getDiary() async {
    try {
      final response = await supabase.from("diary").select();
      return response.map((item) => DiaryPostModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException('글을 가져오는데 실패했어요', originalError: e);
    }
  }

  Future<List<String>> uploadImage(List<String> imagePaths) async {
    try {
      debugPrint('이미지 경로: $imagePaths');
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

      debugPrint('서버 응답 데이터: $responseData');

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
