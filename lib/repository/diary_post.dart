import 'package:trade_diary/dataSource/diary_post.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPostRepo {
  final datasource = DiaryPostDataSource();

  Future<void> addDiaryPost(DiaryPostModel data) async {
    return datasource.createDiaryPost(data);
  }

  Future<List<DiaryPostModel>> getDiary() async {
    return await datasource.getDiary();
  }
}
