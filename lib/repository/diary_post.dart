import 'package:trade_diary/dataSource/diary_post.dart';
import 'package:trade_diary/model/diary_post.dart';

class DiaryPostRepo {
  final datasource = DiaryPostDataSource();

  Future getDiaryPost(String clientId) async {
    return datasource.getDiaryPost(clientId);
  }

  Future<void> addDiaryPost(DiaryPostModel data) async {
    return datasource.createDiaryPost(data);
  }

  Future isUserWriteDiaryToday(String userId) async {
    return datasource.isWriteDiaryToday(userId);
  }

  Future getFriendDiaryPost(String userId) async {
    return datasource.getFriendDiaryPost(userId);
  }
}
