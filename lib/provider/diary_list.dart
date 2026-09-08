import 'dart:async';

import 'package:trade_diary/provider/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trade_diary/dataSource/diary_post.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/diary_post_date_util.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

/// 전체 일기 목록 (위젯 업데이트, 오늘 체크용)
final diaryListProvider = FutureProvider.autoDispose<List<DiaryPostModel>>((
  ref,
) async {
  if (ref.watch(sessionUserProvider) == null) return [];
  ref.watch(koreanDayProvider);
  final viewModel = DiaryViewModel();
  return await viewModel.getDiary();
});

final todayDiaryProvider = Provider<DiaryPostModel?>((ref) {
  final todayOnly = ref.watch(koreanDayProvider);
  final diaryList = ref.watch(diaryListProvider);
  return diaryList.whenOrNull(
    data: (diaries) {
      for (final diary in diaries) {
        final d = diaryDateOnly(diary);
        if (d == todayOnly) return diary;
      }
      return null;
    },
  );
});

final koreanDayProvider = Provider<DateTime>((ref) {
  final now = seoulTime(DateTime.now());
  final next = DateTime.utc(now.year, now.month, now.day + 1);
  final timer = Timer(next.difference(now), ref.invalidateSelf);
  ref.onDispose(timer.cancel);
  return DateTime.utc(now.year, now.month, now.day);
});

// --- 페이지네이션 + 서버 검색 ---

class PaginatedDiaryState {
  final List<DiaryPostModel> items;
  final bool isLoading;
  final bool hasMore;
  final String query;
  final Object? error;

  const PaginatedDiaryState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.query = '',
    this.error,
  });

  PaginatedDiaryState copyWith({
    List<DiaryPostModel>? items,
    bool? isLoading,
    bool? hasMore,
    String? query,
    Object? error,
  }) {
    return PaginatedDiaryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
      error: error,
    );
  }
}

class PaginatedDiaryNotifier extends StateNotifier<PaginatedDiaryState> {
  PaginatedDiaryNotifier() : super(const PaginatedDiaryState()) {
    loadInitial();
  }

  final _dataSource = DiaryPostDataSource();
  int _page = 0;
  int _generation = 0;
  static const _pageSize = 20;

  Future<void> loadInitial() async {
    final generation = ++_generation;
    _page = 0;
    state = PaginatedDiaryState(isLoading: true, query: state.query);
    try {
      final items = await _dataSource.getDiaryPaginated(
        page: 0,
        pageSize: _pageSize,
        query: state.query.isEmpty ? null : state.query,
      );
      if (!mounted || generation != _generation) return;
      state = PaginatedDiaryState(
        items: items,
        hasMore: items.length >= _pageSize,
        query: state.query,
      );
    } catch (e) {
      if (!mounted || generation != _generation) return;
      state = PaginatedDiaryState(error: e, query: state.query);
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;
    final generation = _generation;
    final page = _page + 1;
    state = state.copyWith(isLoading: true);
    try {
      final items = await _dataSource.getDiaryPaginated(
        page: page,
        pageSize: _pageSize,
        query: state.query.isEmpty ? null : state.query,
      );
      if (!mounted || generation != _generation) return;
      _page = page;
      state = state.copyWith(
        items: [...state.items, ...items],
        hasMore: items.length >= _pageSize,
        isLoading: false,
      );
    } catch (e) {
      if (!mounted || generation != _generation) return;
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  void setQuery(String query) {
    state = state.copyWith(query: query);
    loadInitial();
  }

  void refresh() => loadInitial();
}

final paginatedDiaryProvider =
    StateNotifierProvider<PaginatedDiaryNotifier, PaginatedDiaryState>((ref) {
      ref.watch(sessionUserProvider);
      return PaginatedDiaryNotifier();
    });
