import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/repository/diary_post.dart';

class DiaryViewModel {
  final repo = DiaryPostRepo();
  final userId = Supabase.instance.client.auth.currentUser!.id;
  final ImagePicker picker = ImagePicker();

  Future<void> addDiaryPost(DiaryPostModel model)  {
    final value = model.copyWith(userId: userId);
    return repo.addDiaryPost(value);
  }

  Future<List<DiaryPostModel>> getDiary()  {
    return repo.getDiary();
  }

  Future<List<String>> uploadImage(List<String> imagePath)  {
    return repo.uploadImage(imagePath);
  }
}
