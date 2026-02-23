import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/dataSource/diary_post.dart';
import 'package:trade_diary/util/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryViewModel {
  final _dataSource = DiaryPostDataSource();
  final ImagePicker picker = ImagePicker();

  String get userId {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      throw AuthenticationException('로그인이 필요합니다');
    }
    return user.id;
  }

  Future<void> addDiaryPost(DiaryPostModel model, WidgetRef ref) async {
    try {
      final existing = await _dataSource.getDiary();
      final today = DateTime.now();
      final todayOnly = DateTime(today.year, today.month, today.day);
      final hasTodayDiary = existing.any((d) {
        final dd = DateTime(d.date.year, d.date.month, d.date.day);
        return dd == todayOnly;
      });
      if (hasTodayDiary) {
        throw DatabaseException('오늘은 이미 일기를 작성했어요');
      }

      final value = model.copyWith(userId: userId);
      await _dataSource.createDiaryPost(value);
      ref.read(diaryRefreshProvider.notifier).state =
          !ref.read(diaryRefreshProvider);
      ref.read(profileProvider.notifier).refresh();
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('일기 작성 중 오류가 발생했습니다', originalError: e);
    }
  }

  Future<List<DiaryPostModel>> getDiary() async {
    try {
      return await _dataSource.getDiary();
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('일기를 가져오는 중 오류가 발생했습니다', originalError: e);
    }
  }

  Future<List<String>> uploadImage(List<String> imagePath) async {
    try {
      return await _dataSource.uploadImage(imagePath);
    } catch (e) {
      if (e is AppException) rethrow;
      throw NetworkException('이미지 업로드 중 오류가 발생했습니다', originalError: e);
    }
  }

  Future<DiaryPostModel?> getLatestDraft() async {
    return await _dataSource.getLatestDraft();
  }

  Future<DiaryPostModel?> getDraftById(String id) async {
    return await _dataSource.getDraftById(id);
  }

  Future<void> deleteDraft(String id) async {
    await _dataSource.deleteDraft(id);
  }

  Future<List<DiaryPostModel>> getDiaryPaginated({
    int page = 0,
    int pageSize = 20,
    String? query,
  }) async {
    try {
      return await _dataSource.getDiaryPaginated(
        page: page,
        pageSize: pageSize,
        query: query,
      );
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('일기를 가져오는 중 오류가 발생했습니다', originalError: e);
    }
  }

  /// 드래프트 저장 (upsert). 반환값은 드래프트 ID.
  Future<String> saveDraft(DiaryPostModel model, WidgetRef ref) async {
    try {
      final value = model.copyWith(userId: userId, isDraft: true);
      return await _dataSource.upsertDraft(value);
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('임시저장 중 오류가 발생했습니다', originalError: e);
    }
  }

  /// 드래프트를 완성된 일기로 전환
  Future<void> finalizeDraft(
      String id, DiaryPostModel model, WidgetRef ref) async {
    try {
      await _dataSource.finalizeDraft(id, model.copyWith(userId: userId));
      ref.read(diaryRefreshProvider.notifier).state =
          !ref.read(diaryRefreshProvider);
      ref.read(profileProvider.notifier).refresh();
    } catch (e) {
      if (e is AppException) rethrow;
      throw DatabaseException('일기 저장 중 오류가 발생했습니다', originalError: e);
    }
  }
}
