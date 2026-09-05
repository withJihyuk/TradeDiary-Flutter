import 'package:trade_diary/dataSource/diary_post.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryViewModel {
  Future<List<DiaryPostModel>> getDiary() => DiaryPostDataSource().getDiary();
}
