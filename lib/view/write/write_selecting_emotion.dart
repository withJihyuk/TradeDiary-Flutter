import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/provider/write_diary.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/service/draft_store.dart';
import 'package:trade_diary/util/emotion.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class WriteSelectingEmotion extends ConsumerStatefulWidget {
  const WriteSelectingEmotion({super.key, this.draftId});
  final String? draftId;
  @override
  ConsumerState<WriteSelectingEmotion> createState() =>
      _WriteSelectingEmotionState();
}

class _WriteSelectingEmotionState extends ConsumerState<WriteSelectingEmotion> {
  bool _saving = false;
  Future<void> _saveEmotion(String value) async {
    ref.read(diaryProvider.notifier).setEmotion(value);
    final id = ref.read(draftStoreProvider).activeId ?? widget.draftId;
    if (id == null) return;
    final controller = ref.read(quillControllerProvider);
    await ref
        .read(draftStoreProvider)
        .update(
          ref
              .read(diaryProvider)
              .copyWith(
                id: id,
                content: QuillContentUtil.documentToContent(
                  controller.document,
                ),
              ),
        );
  }

  Future<void> _complete() async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      final plain = QuillContentUtil.documentToPlainText(
        ref.read(quillControllerProvider).document,
      );
      if (plain.isEmpty || plain.length > 500) {
        throw StateError('내용은 1자 이상 500자 이내로 입력해 주세요');
      }
      final id = ref.read(draftStoreProvider).activeId ?? widget.draftId;
      if (id == null) throw StateError('작성 화면에서 다시 시도해 주세요');
      await _saveEmotion(ref.read(diaryProvider).emotion);
      if (!mounted) return;
      await ref.read(draftStoreProvider).complete(id);
      if (!mounted) return;
      ref.invalidate(diaryListProvider);
      ref.invalidate(paginatedDiaryProvider);
      ref.invalidate(profileProvider);
      ref.read(diaryProvider.notifier).reset();
      PageRouter.router.go('/diary');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e is StateError
                  ? e.message.toString()
                  : '완료하지 못했어요. 임시저장은 보존돼요. 연결을 확인하고 다시 시도해 주세요',
            ),
            action: SnackBarAction(
              label: '일기 목록',
              onPressed: () => PageRouter.router.go('/diary'),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = ref.watch(diaryProvider).emotion;
    return PopScope(
      canPop: !_saving,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IgnorePointer(
                      ignoring: _saving,
                      child: const TopNavigationBar(title: '감정 선택'),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40.h),
                            Text(
                              '감정선택',
                              style: AppTextStyle.m3Regular.copyWith(
                                color: DiaryMainGrey.grey800,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: Emotion.emotionMap.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 30,
                                    crossAxisSpacing: 30,
                                  ),
                              itemBuilder: (context, index) {
                                final entry = Emotion.emotionMap.entries
                                    .elementAt(index);
                                final isSelected = selected == entry.key;
                                return Semantics(
                                  selected: isSelected,
                                  button: true,
                                  label: entry.key,
                                  child: OutlinedButton(
                                    onPressed: _saving
                                        ? null
                                        : () {
                                            unawaited(
                                              _saveEmotion(entry.key)
                                                  .catchError((Object _) {}),
                                            );
                                          },
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(30),
                                      backgroundColor: isSelected
                                          ? const Color(0xFFF5E0CE)
                                          : DiaryMainGrey.grey50,
                                      side: isSelected
                                          ? const BorderSide(
                                              color: DiaryColor.globalMainColor,
                                              width: 2,
                                            )
                                          : BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Image.asset(
                                      entry.value,
                                      width: 100.w,
                                      height: 100.h,
                                      excludeFromSemantics: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20.h,
                left: 20.h,
                right: 20.h,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: DiaryButton(
                    onPressed: _complete,
                    isDisabled: _saving,
                    text: _saving ? '저장 중…' : '완료하기',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
