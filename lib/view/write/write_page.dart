import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/provider/font_provider.dart';
import 'package:trade_diary/provider/write_diary.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/util/diary_image_embed_builder.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/service/draft_store.dart';
import 'package:uuid/uuid.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

part 'write_scaffold.dart';
part 'write_subject_input.dart';
part 'write_content_input.dart';
part 'write_editor_toolbar.dart';
part 'write_text_toolbar.dart';
part 'write_toolbar_common.dart';
part 'write_color_picker.dart';
part 'write_link_sheet.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key, this.draftId});
  final String? draftId;
  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final FocusNode _editorFocusNode = FocusNode();
  final TextEditingController _subjectController = TextEditingController();
  QuillController? _attached;
  late final String _id = widget.draftId ?? const Uuid().v4();
  late DraftStore _store;
  bool _loading = true;
  bool _storeBound = false;
  bool _leaving = false;
  bool _allowPop = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _loadError = null;
    });
    _store = ref.read(draftStoreProvider);
    _storeBound = true;
    try {
      await _store.ready;
      _store.activeId = _id;
      final draft = widget.draftId == null ? null : await _store.open(_id);
      if (!mounted) return;
      if (widget.draftId != null && draft == null) {
        throw StateError('임시저장 글이 없거나 이미 완료되었어요');
      }
      ref.read(diaryProvider.notifier).reset();
      ref.read(writeStartTimeProvider.notifier).state =
          draft?.createdAt ?? DateTime.now();
      ref.read(inlineTypingStyleProvider.notifier).state = const Style();
      ref.read(inlineTypingOffsetProvider.notifier).state = null;
      final controller = ref.read(quillControllerProvider);
      controller.document = QuillContentUtil.contentToDocument(
        draft?.content ?? '',
      );
      controller.updateSelection(
        TextSelection.collapsed(offset: controller.document.length - 1),
        ChangeSource.local,
      );
      _subjectController.text = draft?.subject ?? '';
      final notifier = ref.read(diaryProvider.notifier);
      notifier.setSubject(draft?.subject ?? '');
      notifier.setContent(draft?.content ?? '');
      notifier.setEmotion(draft?.emotion ?? '배고픈감자');
      _attached?.removeListener(_changed);
      _subjectController.removeListener(_changed);
      _attached = controller;
      controller.addListener(_changed);
      _subjectController.addListener(_changed);
      setState(() => _loading = false);
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadError = '글을 불러오지 못했어요. 연결을 확인하고 다시 시도해 주세요';
        });
      }
    }
  }

  Future<void> _save() async {
    if (_loading || _loadError != null || _attached == null) return;
    final content = QuillContentUtil.documentToContent(_attached!.document);
    final diary = ref
        .read(diaryProvider)
        .copyWith(
          id: _store.activeId ?? _id,
          subject: _subjectController.text,
          content: content,
        );
    await _store.update(diary);
  }

  void _changed() {
    if (!mounted || _loading) return;
    unawaited(
      _save().catchError((Object _) {}),
    ); // Store exposes local failure and blocks exit.
  }

  Future<void> _leave({bool next = false}) async {
    if (_leaving) return;
    setState(() => _leaving = true);
    try {
      await _save();
      await _store.flush();
      if (!mounted) return;
      if (next) {
        await PageRouter.router.push('/select', extra: _store.activeId ?? _id);
      } else {
        setState(() => _allowPop = true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (PageRouter.router.canPop()) {
            PageRouter.router.pop();
          } else {
            PageRouter.router.go('/home');
          }
        });
      }
    } catch (_) {
      if (!mounted) return;
      final discard = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('기기에 저장하지 못했어요'),
          content: const Text(
            '저장 공간을 확인하고 다시 시도해 주세요. 저장하지 않고 나가면 마지막 변경이 사라질 수 있어요.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('계속 작성'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('저장하지 않고 나가기'),
            ),
          ],
        ),
      );
      if (discard == true && mounted) PageRouter.router.go('/diary');
    } finally {
      if (mounted) setState(() => _leaving = false);
    }
  }

  @override
  void dispose() {
    if (_storeBound) _store.activeId = null;
    _attached?.removeListener(_changed);
    _subjectController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(draftStoreProvider);
    final status = store.status(store.activeId ?? _id);
    final saveFailed = store.localError != null || store.error != null;
    if (_loading || _loadError != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('일기')),
        body: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_loadError!),
                    TextButton(onPressed: _load, child: const Text('다시 시도')),
                  ],
                ),
        ),
      );
    }
    return PopScope(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _leave();
      },
      child: _Scaffold(
        header: TopNavigationBar(title: '일기', onBack: () => _leave()),
        autoSaveStatus: Container(
          width: double.infinity,
          color: saveFailed ? const Color(0xFFFFF5EC) : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              Icon(
                store.localError != null
                    ? Icons.error_outline_rounded
                    : store.error != null
                    ? Icons.cloud_off_outlined
                    : status == '저장 중' || status == '동기화 중'
                    ? Icons.sync_rounded
                    : status == '자동 저장됨'
                    ? Icons.cloud_done_outlined
                    : Icons.save_outlined,
                size: 15,
                color: DiaryMainGrey.grey700,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  status,
                  style: AppTextStyle.labelRegular.copyWith(
                    fontSize: 12,
                    color: DiaryMainGrey.grey800,
                  ),
                ),
              ),
              if (saveFailed)
                TextButton(
                  onPressed: () async {
                    try {
                      await _save();
                      await store.flush();
                      await store.sync();
                    } catch (_) {}
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: DiaryMainGrey.grey900,
                    textStyle: AppTextStyle.labelRegular.copyWith(fontSize: 12),
                  ),
                  child: const Text('다시 시도'),
                ),
            ],
          ),
        ),
        subjectInput: _WriteSubjectInput(
          editorFocusNode: _editorFocusNode,
          controller: _subjectController,
        ),
        editor: _WriteContentInput(editorFocusNode: _editorFocusNode),
        toolbar: _EditorToolbar(editorFocusNode: _editorFocusNode),
        submitButton: DiaryButton(
          onPressed: () => _leave(next: true),
          text: _leaving ? '저장 중' : '다음',
        ),
      ),
    );
  }
}
