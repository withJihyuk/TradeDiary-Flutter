import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/repository/diary_post.dart';

import '../dataSource/diary_post.dart';

class DiaryPostViewModel {
  final repo = DiaryPostRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  Future<void> addDiaryPost(String content, bool isPrivate, String subject,
      String emotion, List<String> image, DateTime date) async {
    final DiaryPostModel model = DiaryPostModel(
      subject: subject,
      content: content,
      date: date,
      emotion: emotion,
      image: image,
      isPrivate: isPrivate,
    );
    return repo.addDiaryPost(model);
  }

  String getTodayDate() {
    final now = DateTime.now();
    return "${now.month}월 ${now.day}일";
  }
}

final diaryPostProvider =
    FutureProvider.family<List<DiaryPostModel>, String>((ref, postId) async {
  final dataSource = DiaryPostDataSource();
  try {
    if (postId.isEmpty) {
      throw ArgumentError('게시물 ID가 비어있습니다.');
    }
    return await dataSource.getDiaryPost(postId);
  } catch (e, st) {
    throw AsyncError('게시물을 불러오는 중 오류가 발생했습니다: $e', st);
  }
});
