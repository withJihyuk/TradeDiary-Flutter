import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/provider/font_provider.dart';
import 'package:trade_diary/provider/write_diary.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/util/diary_image_embed_builder.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/viewModel/diary_model.dart';
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
  Timer? _autoSaveTimer;
  String? _draftId;
  bool _isDirty = false;
  DateTime? _lastSavedAt;
  Future<void>? _savingFuture;
  QuillController? _attachedQuillController;
  final FocusNode _editorFocusNode = FocusNode();
  final TextEditingController _subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(writeStartTimeProvider.notifier).state = DateTime.now();
      ref.read(inlineTypingStyleProvider.notifier).state = const Style();
      ref.read(inlineTypingOffsetProvider.notifier).state = null;
      final controller = ref.read(quillControllerProvider);
      _bindContentListener(controller);
      _checkDraft();
    });
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_isDirty) _saveDraft();
    });
  }

  @override
  void dispose() {
    _attachedQuillController?.removeListener(_onContentChanged);
    _attachedQuillController = null;
    _autoSaveTimer?.cancel();
    _editorFocusNode.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  void _bindContentListener(QuillController controller) {
    if (_attachedQuillController == controller) return;
    _attachedQuillController?.removeListener(_onContentChanged);
    _attachedQuillController = controller;
    controller.addListener(_onContentChanged);
  }

  Future<void> _checkDraft() async {
    if (widget.draftId != null) {
      final draft = await DiaryViewModel().getDraftById(widget.draftId!);
      if (draft != null && mounted) _restoreDraft(draft);
      return;
    }

    final draft = await DiaryViewModel().getLatestDraft();
    if (draft == null || !mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('작성 중인 글이 있습니다'),
        content: Text(
          '${_formatDraftDate(draft.updatedAt ?? draft.createdAt ?? DateTime.now())}에 작성중이던 내용이 있습니다.\n이어서 작성하시겠습니까?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('새로 작성',
                style: TextStyle(color: DiaryColor.globalMainColor)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('이어쓰기',
                style: TextStyle(color: DiaryColor.globalMainColor)),
          ),
        ],
      ),
    );

    if (!mounted) return;

    if (confirmed == true) {
      _restoreDraft(draft);
    }
  }

  void _restoreDraft(DiaryPostModel draft) {
    final doc = QuillContentUtil.contentToDocument(draft.content);
    final restoredController = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
    ref.read(quillControllerProvider.notifier).state = restoredController;
    _bindContentListener(restoredController);

    _subjectController.text = draft.subject;
    final notifier = ref.read(diaryProvider.notifier);
    notifier.setSubject(draft.subject);
    if (draft.emotion.isNotEmpty) notifier.setEmotion(draft.emotion);

    _draftId = draft.id;
    setState(() {});
  }

  String _formatDraftDate(DateTime dt) {
    final day = dt.day;
    final hour = dt.hour;
    final minute = dt.minute;
    final period = hour < 12 ? '오전' : '오후';
    final displayHour = hour <= 12 ? hour : hour - 12;
    return '$day일 $period $displayHour시 $minute분';
  }

  void _onContentChanged() {
    if (!mounted) return;
    _isDirty = true;
    ref.read(lastModifiedTimeProvider.notifier).state = DateTime.now();
  }

  Future<void> _saveDraft() async {
    if (!mounted) return;
    final future = _doSaveDraft();
    _savingFuture = future;
    await future;
  }

  Future<void> _doSaveDraft() async {
    try {
      final quillController = ref.read(quillControllerProvider);
      final content =
          QuillContentUtil.documentToContent(quillController.document);
      final diary = ref.read(diaryProvider);

      _draftId = await DiaryViewModel().saveDraft(
        diary.copyWith(content: content, isDraft: true, id: _draftId),
        ref,
      );
      _isDirty = false;
      if (mounted) {
        setState(() => _lastSavedAt = DateTime.now());
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return _Scaffold(
      header: const TopNavigationBar(title: "일기"),
      autoSaveStatus: _lastSavedAt != null
          ? Align(
              alignment: Alignment.centerRight,
              child: Text(
                '임시저장됨 ${DateFormat('a h:mm', 'ko_KR').format(_lastSavedAt!)}',
                style: AppTextStyle.labelRegular
                    .copyWith(color: DiaryMainGrey.grey500, fontSize: 12),
              ),
            )
          : null,
      subjectInput: _WriteSubjectInput(
        editorFocusNode: _editorFocusNode,
        controller: _subjectController,
      ),
      editor: _WriteContentInput(editorFocusNode: _editorFocusNode),
      toolbar: _EditorToolbar(editorFocusNode: _editorFocusNode),
      submitButton: DiaryButton(
        onPressed: () async {
          _autoSaveTimer?.cancel();
          if (_savingFuture != null) await _savingFuture;
          if (_draftId == null && _isDirty) await _saveDraft();
          if (!mounted) return;
          PageRouter.router.push("/select", extra: _draftId);
        },
        text: "다음",
      ),
    );
  }
}
