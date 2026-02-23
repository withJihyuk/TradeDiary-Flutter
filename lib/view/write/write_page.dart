import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
part 'write_info_panel.dart';

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
  bool _showInfoPanel = false;
  final FocusNode _editorFocusNode = FocusNode();
  final TextEditingController _subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(writeStartTimeProvider.notifier).state = DateTime.now();
      final controller = ref.read(quillControllerProvider);
      controller.addListener(_onContentChanged);
      _checkDraft();
    });
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_isDirty) _saveDraft();
    });
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _editorFocusNode.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _checkDraft() async {
    // 리스트에서 특정 드래프트를 눌러 진입한 경우 해당 드래프트 바로 복원
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
          '${_formatDraftDate(draft.updatedAt ?? draft.date)}에 작성중이던 내용이 있습니다.\n이어서 작성하시겠습니까?',
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
    // QuillController에 content 복원
    final doc = QuillContentUtil.contentToDocument(draft.content);
    ref.read(quillControllerProvider.notifier).state = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
    ref.read(quillControllerProvider).addListener(_onContentChanged);

    // 제목 복원
    _subjectController.text = draft.subject;
    final notifier = ref.read(diaryProvider.notifier);
    notifier.setSubject(draft.subject);
    notifier.setDate(draft.date);
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
    } catch (_) {
      // 자동 저장 실패는 조용히 무시
    }
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
      toolbar: _EditorToolbarWithInfo(
        showInfoPanel: _showInfoPanel,
        onToggleInfo: () =>
            setState(() => _showInfoPanel = !_showInfoPanel),
      ),
      infoPanel: _showInfoPanel ? const _InfoPanel() : null,
      submitButton: DiaryButton(
        onPressed: () {
          // draftId를 route extra로 전달
          PageRouter.router.push("/select", extra: _draftId);
        },
        text: "다음",
      ),
    );
  }
}

/// 툴바 + 정보 패널 토글 버튼을 포함하는 래퍼
class _EditorToolbarWithInfo extends ConsumerWidget {
  const _EditorToolbarWithInfo({
    required this.showInfoPanel,
    required this.onToggleInfo,
  });

  final bool showInfoPanel;
  final VoidCallback onToggleInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(child: _EditorToolbar()),
            // 정보 패널 토글 버튼
            IconButton(
              icon: Icon(
                showInfoPanel ? Icons.info : Icons.info_outline,
                color: showInfoPanel
                    ? DiaryColor.globalMainColor
                    : DiaryMainGrey.grey700,
                size: 20,
              ),
              onPressed: onToggleInfo,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ],
    );
  }
}
