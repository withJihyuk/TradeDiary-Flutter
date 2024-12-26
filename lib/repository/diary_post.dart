import 'package:trade_diary/dataSource/diary_post.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPostRepo {
  final datasource = DiaryPostDataSource();

  Future<List> getDiaryPost(String postId) async {
    return await datasource.getDiaryPost(postId).onError((error, stackTrace) {
      return [];
    });
  }

  Future<void> addDiaryPost(DiaryPostModel data) async {
    return datasource.createDiaryPost(data);
  }

  Future<List<DiaryPostModel>> getDiary() async {
    return await datasource.getDiary().onError((error, stackTrace) {
      return [];
    });
  }
}
