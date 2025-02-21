import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:http/http.dart' as http;
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

  Future<List<String>> uploadImage(List<String> imagePath) async {
    if (imagePath.isEmpty) {
      return [];
    }
    
    var request = http.MultipartRequest(
        "POST", Uri.parse("${dotenv.env['API_URL']}/image"));
    request.headers['Authorization'] =
        "Bearer ${supabase.auth.currentSession?.accessToken}";
    for (var path in imagePath) {
      if (path != null && path.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', path));
      }
    }
    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('이미지 업로드에 실패했어요');
    }
    
    var responseData = await response.stream.bytesToString();
    Map<String, dynamic> jsonResponse = json.decode(responseData);
    return List<String>.from(jsonResponse['urls'] ?? []);
  }
}
