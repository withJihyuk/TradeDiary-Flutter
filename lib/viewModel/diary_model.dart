import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/repository/diary_post.dart';
import 'package:trade_diary/util/app_exception.dart';

class DiaryViewModel {
  final repo = DiaryPostRepo();
  final ImagePicker picker = ImagePicker();

  String get userId {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      throw AuthenticationException('로그인이 필요합니다');
    }
    return user.id;
  }

  Future<void> addDiaryPost(DiaryPostModel model) async {
    try {
      final value = model.copyWith(userId: userId);
      await repo.addDiaryPost(value);
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('일기 작성 중 오류가 발생했습니다', originalError: e);
    }
  }

  Future<List<DiaryPostModel>> getDiary() async {
    try {
      return await repo.getDiary();
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('일기를 가져오는 중 오류가 발생했습니다', originalError: e);
    }
  }

  Future<List<String>> uploadImage(List<String> imagePath) async {
    try {
      return await repo.uploadImage(imagePath);
    } catch (e) {
      if (e is AppException) rethrow;
      throw NetworkException('이미지 업로드 중 오류가 발생했습니다', originalError: e);
    }
  }
}
