import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPostDataSource {
  final supabase = Supabase.instance.client;

  Future createDiaryPost(DiaryPostModel data) async {
    await supabase.from("diary").insert(data);
  }

  Future<List<DiaryPostModel>> getDiaryPost(String postId) async {
    final response = await supabase
        .from("diary")
        .select()
        .eq('id', postId)
        .catchError((onError) {
      throw Exception('글을 가져오는데 실패했어요');
    });
    return response.map((item) => DiaryPostModel.fromJson(item)).toList();
  }

  Future<List<DiaryPostModel>> getDiary() async {
      final response = await supabase
        .from("diary")
        .select()
        .catchError((onError) {
      throw Exception('글을 가져오는데 실패했어요');
    });
    return response.map((item) => DiaryPostModel.fromJson(item)).toList();
  }
}
