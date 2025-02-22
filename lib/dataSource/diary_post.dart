import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class DiaryPostDataSource {
  final supabase = Supabase.instance.client;

  Future createDiaryPost(DiaryPostModel data) async {
    await supabase.from("diary").insert(data).catchError((onError) {
      throw Exception('글을 작성하는데 실패했어요');
    });
  }

  Future<List<DiaryPostModel>> getDiary() async {
    final response =
        await supabase.from("diary").select().catchError((onError) {
      throw Exception('글을 가져오는데 실패했어요');
    });
    return response.map((item) => DiaryPostModel.fromJson(item)).toList();
  }

  Future<List<String>> uploadImage(List<String> imagePaths) async {
    debugPrint('이미지 경로: $imagePaths');
    final apiUrl = "${dotenv.env['API_URL']}/image";

    var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
    final token = supabase.auth.currentSession?.accessToken;

    request.headers['Authorization'] = "Bearer $token";

    for (var path in imagePaths) {
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

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    debugPrint('서버 응답 데이터: $responseData');

    if (response.statusCode != 201) {
      throw Exception('이미지 업로드에 실패했어요 (상태 코드: ${response.statusCode})');
    }

    List<dynamic> jsonResponse = json.decode(responseData);
    return jsonResponse
        .map<String>((uuid) => "${dotenv.env['CDN_URL']}/$uuid")
        .toList();
  }
}
