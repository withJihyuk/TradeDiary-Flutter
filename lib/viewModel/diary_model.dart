import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/image_response.dart';
import 'package:trade_diary/repository/diary_post.dart';
import 'package:trade_diary/repository/image_upload.dart';

import '../dataSource/diary_post.dart';

class DiaryPostViewModel {
  final repo = DiaryPostRepo();
  final imgRepo = ImageRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  Future<void> addDiaryPost(String content, bool isPrivate) async {
    final DiaryPostModel model = DiaryPostModel(
      userId: userId,
      content: content,
      isPrivate: isPrivate,
    );

    return repo.addDiaryPost(model);
  }

  String getTodayDate() {
    final now = DateTime.now();
    return "${now.month}월 ${now.day}일";
  }

  // Future<List> getDiaryPost(String postId) async {
  //   return repo.getDiaryPost(postId);
  // }

  Future<ImageModel> uploadImage(XFile data) async {
    return await imgRepo.imageUpload(data);
  }

  final getDiaryPost = FutureProvider.family<List<DiaryPostModel>, String>((ref, postId) async {
    return DiaryPostDataSource().getDiaryPost(postId);
  });
}
