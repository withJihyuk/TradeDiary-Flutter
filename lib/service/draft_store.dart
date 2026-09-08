import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:trade_diary/dataSource/diary_post.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/provider/session.dart';
import 'package:trade_diary/util/image_compressor.dart';
import 'package:trade_diary/util/quill_content_util.dart';

final draftStoreProvider = ChangeNotifierProvider<DraftStore>(
  (ref) => DraftStore(ref.watch(sessionUserProvider)),
);

class LocalDraft {
  LocalDraft(
    this.diary, {
    String? mutationId,
    this.completionMutationId,
    this.dirty = false,
    this.deleted = false,
    this.conflict = false,
    Map<String, String>? images,
  }) : mutationId = mutationId ?? const Uuid().v4(),
       images = images ?? {};
  DiaryPostModel diary;
  String mutationId;
  String? completionMutationId;
  bool dirty;
  bool deleted;
  bool conflict;
  final Map<String, String> images;
  Map<String, dynamic> toJson() => {
    'diary': {
      ...diary.toJson(),
      'id': diary.id,
      'isDraft': true,
      'revision': diary.revision,
      'createdAt': diary.createdAt?.toIso8601String(),
      'updatedAt': diary.updatedAt?.toIso8601String(),
    },
    'mutationId': mutationId,
    'completionMutationId': completionMutationId,
    'dirty': dirty,
    'deleted': deleted,
    'conflict': conflict,
    'images': images,
  };
  factory LocalDraft.fromJson(Map<String, dynamic> json) => LocalDraft(
    DiaryPostModel.fromJson(Map<String, dynamic>.from(json['diary'])),
    mutationId: json['mutationId'],
    completionMutationId: json['completionMutationId'],
    dirty: json['dirty'] == true,
    deleted: json['deleted'] == true,
    conflict: json['conflict'] == true,
    images: Map<String, String>.from(json['images'] ?? {}),
  );
}

class DraftStore extends ChangeNotifier with WidgetsBindingObserver {
  DraftStore(this.userId) {
    WidgetsBinding.instance.addObserver(this);
    ready = _load();
    unawaited(
      ready.then((_) => refresh()).catchError((Object e) {
        error = '기기 저장 내용을 불러오지 못했어요';
        _notify();
      }),
    );
  }
  final String? userId;
  final _source = DiaryPostDataSource();
  final Map<String, LocalDraft> _drafts = {};
  late final Future<void> ready;
  Directory? _directory;
  Future<void> _writes = Future.value();
  Future<void>? _syncing;
  Timer? _timer;
  bool _disposed = false;
  bool _active = true;
  bool completing = false;
  String? activeId;
  bool _suspended = false;
  bool refreshing = false;
  int _retry = 0;
  String? error;
  String? localError;
  int _pendingWrites = 0;
  bool get _authorized =>
      !_disposed &&
      !_suspended &&
      userId != null &&
      Supabase.instance.client.auth.currentUser?.id == userId;
  List<LocalDraft> get drafts =>
      _drafts.values.where((d) => !d.deleted).toList()..sort(
        (a, b) => (b.diary.updatedAt ?? DateTime(1970)).compareTo(
          a.diary.updatedAt ?? DateTime(1970),
        ),
      );
  LocalDraft? get(String id) => _drafts[id];
  String status(String id) {
    if (localError != null) return localError!;
    if (!_drafts.containsKey(id)) return '내용을 입력하면 자동 저장돼요';
    if (_pendingWrites > 0) return '저장 중';
    if (_syncing != null) return '동기화 중';
    if (error != null) return '이 기기에 보관 중 · 연결을 확인해 주세요';
    return _drafts[id]?.dirty == true ? '이 기기에 보관됨' : '자동 저장됨';
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  Future<void> _load() async {
    if (userId == null) return;
    _directory = Directory(
      '${(await getApplicationSupportDirectory()).path}/drafts/$userId',
    );
    await _directory!.create(recursive: true);
    final file = File('${_directory!.path}/drafts.json');
    if (await file.exists()) {
      final entries = jsonDecode(await file.readAsString()) as List;
      for (final entry in entries) {
        final draft = LocalDraft.fromJson(Map<String, dynamic>.from(entry));
        if (draft.diary.userId == userId) _drafts[draft.diary.id!] = draft;
      }
    }
    // Only collect unused local image files during startup, before the editor can import photos.
    final referenced = <String>{};
    for (final draft in _drafts.values) {
      referenced.addAll(
        QuillContentUtil.extractLocalImagePaths(
          QuillContentUtil.contentToDocument(draft.diary.content),
        ),
      );
      referenced.addAll(
        draft.images.values.where(
          (path) => path.startsWith('${_directory!.path}/'),
        ),
      );
    }
    await for (final entry in _directory!.list()) {
      if (entry is File &&
          RegExp(r'/[0-9a-f-]{36}\.(webp|jpeg|png)$').hasMatch(entry.path) &&
          !referenced.contains(entry.path)) {
        try {
          await entry.delete();
        } on FileSystemException {
          /* Retry cleanup at next startup. */
        }
      }
    }
    _notify();
  }

  // ponytail: One JSON file suits small draft collections; use SQLite if whole-file writes become slow.
  Future<void> _persist() {
    _pendingWrites++;
    final task = _writes.catchError((Object _) {}).then((_) async {
      if (_directory == null) throw StateError('로그인이 필요합니다');
      final tmp = File('${_directory!.path}/drafts.json.tmp');
      await tmp.writeAsString(
        jsonEncode(_drafts.values.map((d) => d.toJson()).toList()),
        flush: true,
      );
      await tmp.rename('${_directory!.path}/drafts.json');
      localError = null;
    });
    _writes = task;
    return task.then(
      (_) {
        _pendingWrites--;
        _notify();
      },
      onError: (Object e, StackTrace st) {
        _pendingWrites--;
        localError = '기기 저장 실패 · 재시도';
        _notify();
        Error.throwWithStackTrace(e, st);
      },
    );
  }

  Future<void> flush() async {
    await ready;
    await _persist();
  }

  bool _empty(DiaryPostModel d) =>
      d.subject.trim().isEmpty &&
      QuillContentUtil.contentToPlainText(d.content).trim().isEmpty &&
      !d.content.contains('"image"');
  Future<void> update(DiaryPostModel diary) async {
    await ready;
    if (!_authorized || completing) return;
    final old = _drafts[diary.id];
    if (old == null && _empty(diary)) return;
    if (old != null &&
        old.diary.subject == diary.subject &&
        old.diary.content == diary.content &&
        old.diary.emotion == diary.emotion) {
      return;
    }
    final next = diary.copyWith(
      userId: userId!,
      isDraft: true,
      revision: old?.diary.revision ?? 0,
      updatedAt: DateTime.now().toUtc(),
    );
    _drafts[diary.id!] = LocalDraft(
      next,
      dirty: true,
      images: Map.of(old?.images ?? {}),
      conflict: old?.conflict ?? false,
    );
    await _persist();
    _schedule();
  }

  void _schedule([Duration delay = const Duration(seconds: 2)]) {
    _timer?.cancel();
    if (_active && _authorized && !completing) {
      _timer = Timer(delay, () => unawaited(sync()));
    }
  }

  Future<String> importImage(String path) async {
    await ready;
    if (!_authorized) throw StateError('로그인이 필요합니다');
    final bytes =
        await ImageCompressor.compressToWebP(path) ??
        await File(path).readAsBytes();
    final mime = DiaryPostDataSource.imageMime(bytes);
    if (bytes.length > 16 * 1024 * 1024) {
      throw StateError('사진 한 장의 크기는 16MB 이하여야 해요');
    }
    final file = File(
      '${_directory!.path}/${const Uuid().v4()}.${mime.split('/').last}',
    );
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  Future<DiaryPostModel?> open(String id) async {
    await ready;
    if (_drafts[id] != null) return _drafts[id]!.diary;
    final diary = await _source.getById(id);
    if (!_authorized || diary == null || !diary.isDraft) return null;
    _drafts[id] = LocalDraft(diary);
    await _persist();
    return diary;
  }

  Future<void> refresh() async {
    try {
      await ready;
    } catch (_) {
      localError = '기기 저장 내용을 불러오지 못했어요';
      _notify();
      return;
    }
    if (!_authorized || refreshing || completing) return;
    refreshing = true;
    _notify();
    try {
      await sync();
      final before = {
        for (final entry in _drafts.entries)
          entry.key: (entry.value.mutationId, entry.value.diary.revision),
      };
      final rows = await _source.getDrafts();
      if (!_authorized || completing) return;
      bool unchanged(String id, LocalDraft d) =>
          before[id] == (d.mutationId, d.diary.revision);
      final ids = rows.map((d) => d.id).toSet();
      _drafts.removeWhere(
        (id, d) =>
            id != activeId && !d.dirty && !ids.contains(id) && unchanged(id, d),
      );
      for (final row in rows) {
        if (row.id == activeId && _drafts.containsKey(row.id)) continue;
        final current = _drafts[row.id];
        if ((current == null && !before.containsKey(row.id)) ||
            (current != null &&
                !current.dirty &&
                unchanged(row.id!, current))) {
          _drafts[row.id!] = LocalDraft(row);
        }
      }
      await _persist();
    } catch (_) {
      error = '동기화 실패';
    } finally {
      refreshing = false;
      _notify();
    }
  }

  Future<void> sync() {
    if (_syncing != null) return _syncing!;
    if (!_authorized || completing) return Future.value();
    final task = _syncAll();
    _syncing = task;
    _notify();
    return task.whenComplete(() {
      _syncing = null;
      _notify();
      if (error == null && _drafts.values.any((d) => d.dirty)) _schedule();
    });
  }

  Future<DiaryPostModel> _upload(LocalDraft draft) async {
    final doc = QuillContentUtil.contentToDocument(draft.diary.content);
    final paths = QuillContentUtil.extractLocalImagePaths(doc).toSet().toList();
    for (final path in paths) {
      if (!_authorized) throw StateError('계정이 변경되었어요');
      if (!draft.images.containsKey(path)) {
        // Legacy cached paths are copied once, and their stable mapping is persisted before upload.
        var uploadPath = path;
        if (!path.startsWith('${_directory!.path}/')) {
          uploadPath = draft.images['local:$path'] ?? await importImage(path);
          draft.images['local:$path'] = uploadPath;
          _drafts[draft.diary.id]?.images.addAll(draft.images);
          await _persist();
        }
        final uploaded = (await _source.uploadImage([uploadPath])).single;
        if (!_authorized) throw StateError('계정이 변경되었어요');
        draft.images[path] = uploaded;
        // The current in-memory revision may have changed during the network request.
        _drafts[draft.diary.id]?.images.addAll(draft.images);
        await _persist();
      }
    }
    return draft.diary.copyWith(
      content: QuillContentUtil.replaceImagePaths(
        doc,
        paths,
        paths.map((p) => draft.images[p]!).toList(),
      ),
    );
  }

  Future<void> _fork(LocalDraft local, Map<String, dynamic> response) async {
    final current = _drafts[local.diary.id];
    if (current == null) return;
    if (!current.deleted && !_empty(current.diary)) {
      final id = const Uuid().v4();
      if (activeId == local.diary.id) activeId = id;
      _drafts[id] = LocalDraft(
        current.diary.copyWith(
          id: id,
          revision: 0,
          updatedAt: DateTime.now().toUtc(),
        ),
        dirty: true,
        conflict: true,
        images: Map.of(current.images),
      );
    }
    _drafts.remove(local.diary.id);
    if (response['diary'] != null) {
      final server = DiaryPostModel.fromJson(
        Map<String, dynamic>.from(response['diary']),
      );
      if (server.isDraft) {
        _drafts[server.id!] = LocalDraft(server, conflict: current.deleted);
      }
    }
    await _persist();
    _schedule();
  }

  Future<void> _syncAll() async {
    await ready;
    try {
      await _persist();
      for (final local
          in _drafts.values
              .map((d) => LocalDraft.fromJson(d.toJson()))
              .toList()) {
        if (!_authorized || completing) break;
        if (!local.dirty) continue;
        final outgoing = local.deleted ? local.diary : await _upload(local);
        if (!_authorized) break;
        final result = await _source.mutate(
          local.deleted ? 'delete_draft' : 'save_draft',
          outgoing,
          local.mutationId,
        );
        if (!_authorized) break;
        final current = _drafts[local.diary.id];
        if (result['status'] == 'saved') {
          final server = DiaryPostModel.fromJson(
            Map<String, dynamic>.from(result['diary']),
          );
          if (current != null) {
            current.diary = current.diary.copyWith(revision: server.revision);
            if (current.mutationId == local.mutationId) current.dirty = false;
          }
        } else if (result['status'] == 'completed' &&
            result['diary']?['lastMutationId'] == local.completionMutationId &&
            local.completionMutationId != null &&
            current?.mutationId == local.mutationId) {
          _drafts.remove(local.diary.id);
        } else if (result['status'] == 'deleted' && local.deleted) {
          _drafts.remove(local.diary.id);
        } else {
          await _fork(local, result);
        }
        await _persist();
      }
      error = null;
      _retry = 0;
    } catch (_) {
      error = '동기화 실패';
      if (_retry < 4) _schedule(Duration(seconds: [2, 5, 15, 30][_retry++]));
    }
  }

  Future<void> delete(String id) async {
    await ready;
    final local = _drafts[id];
    if (local == null) return;
    local.deleted = true;
    local.dirty = true;
    local.mutationId = const Uuid().v4();
    await _persist();
    _schedule();
  }

  Future<DiaryPostModel> complete(String id) async {
    await ready;
    if (completing) throw StateError('저장 중이에요');
    _timer?.cancel();
    await _syncing;
    if (!_authorized) throw StateError('로그인이 필요합니다');
    final local = _drafts[id];
    if (local == null) throw StateError('임시저장 목록에서 보존된 글을 다시 열어 주세요');
    completing = true;
    local.completionMutationId ??= const Uuid().v4();
    _notify();
    try {
      await _persist();
      final outgoing = await _upload(local);
      if (!_authorized) throw StateError('계정이 변경되었어요');
      final result = await _source.mutate(
        'finalize_diary',
        outgoing,
        local.completionMutationId!,
      );
      if (!_authorized) throw StateError('계정이 변경되었어요');
      if (result['status'] == 'duplicate_day') {
        throw StateError('오늘은 이미 일기를 작성했어요. 이 글은 임시저장 목록에 보관했어요');
      }
      if (result['status'] != 'completed' ||
          result['diary']?['lastMutationId'] != local.completionMutationId!) {
        await _fork(local, result);
        throw StateError('다른 기기의 변경이 있어요. 임시저장 목록에 내용을 보존했어요');
      }
      final diary = DiaryPostModel.fromJson(
        Map<String, dynamic>.from(result['diary']),
      );
      _drafts.remove(id);
      await _persist();
      return diary;
    } on TimeoutException {
      final server = await _source.getById(id);
      if (server != null &&
          !server.isDraft &&
          server.lastMutationId == local.completionMutationId! &&
          _authorized) {
        _drafts.remove(id);
        await _persist();
        return server;
      }
      rethrow;
    } finally {
      completing = false;
      _notify();
      if (_drafts.values.any((d) => d.dirty)) _schedule();
    }
  }

  Future<void> suspend() async {
    _suspended = true;
    _timer?.cancel();
    await _syncing;
    await _writes;
  }

  void resume() {
    _suspended = false;
    _schedule();
  }

  Future<void> purge() async {
    _timer?.cancel();
    await _syncing;
    await _writes;
    _drafts.clear();
    if (_directory != null && await _directory!.exists()) {
      await _directory!.delete(recursive: true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _active = state == AppLifecycleState.resumed;
    if (_active) {
      _retry = 0;
      unawaited(refresh());
    } else {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
