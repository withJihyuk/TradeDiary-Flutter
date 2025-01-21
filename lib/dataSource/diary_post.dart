import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';

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
}
