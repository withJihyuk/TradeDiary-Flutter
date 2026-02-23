import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/write_diary.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/util/emotion.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';
import 'package:trade_diary/viewModel/diary_model.dart';
import 'package:trade_diary/service/streak_service.dart';
import 'package:trade_diary/provider/profile_provider.dart';

class WriteSelectingEmotion extends ConsumerStatefulWidget {
  const WriteSelectingEmotion({super.key, this.draftId});

  final String? draftId;

  @override
  ConsumerState<WriteSelectingEmotion> createState() =>
      _WriteSelectingEmotionState();
}

class _WriteSelectingEmotionState extends ConsumerState<WriteSelectingEmotion> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = DiaryViewModel();
    var selectedEmotion = ref.watch(diaryProvider).emotion;

    return ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
            body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopNavigationBar(title: "감정 선택"),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40.h),
                            Text(
                              "감정선택",
                              style: AppTextStyle.m3Regular
                                  .copyWith(color: DiaryMainGrey.grey800),
                            ),
                            SizedBox(height: 12.h),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: Emotion.emotionMap.keys.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 30,
                                crossAxisSpacing: 30,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final emotionName =
                                    Emotion.emotionMap.keys.elementAt(index);
                                final emotionImage =
                                    Emotion.emotionMap[emotionName]!;

                                return GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(diaryProvider.notifier)
                                        .setEmotion(emotionName);
                                  },
                                  child: Container(
                                    width: 160.w,
                                    height: 160.h,
                                    padding: const EdgeInsets.all(30),
                                    decoration: (selectedEmotion == emotionName)
                                        ? BoxDecoration(
                                            color: const Color(0xFFF5E0CE),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color:
                                                    DiaryColor.globalMainColor,
                                                width: 2))
                                        : BoxDecoration(
                                            color: DiaryMainGrey.grey50,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                    child: Image.asset(emotionImage,
                                        width: 100.w, height: 100.h),
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
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: _isSaving
                    ? SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: DiaryColor.globalMainColor,
                            disabledBackgroundColor: DiaryColor.globalMainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '저장 중...',
                                style: AppTextStyle.m2Semi.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : DiaryButton(
                        onPressed: () async {
                          if (!mounted || _isSaving) return;

                          setState(() => _isSaving = true);

                          try {
                            // Delta → JSON 직렬화 + 500자 검증
                            final quillController = ref.read(quillControllerProvider);
                            final plainText = quillController.document.toPlainText().trim();

                            if (plainText.isEmpty) {
                              setState(() => _isSaving = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('내용을 입력해 주세요'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            if (plainText.length > 500) {
                              setState(() => _isSaving = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('내용은 500자 이내로 입력해 주세요'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // 인라인 이미지 추출 → 업로드 → CDN URL 치환
                            final localPaths = QuillContentUtil.extractLocalImagePaths(quillController.document);
                            List<String> cdnUrls = [];
                            if (localPaths.isNotEmpty) {
                              cdnUrls = await viewModel.uploadImage(localPaths);
                            }

                            final contentJson = localPaths.isNotEmpty
                                ? QuillContentUtil.replaceImagePaths(quillController.document, localPaths, cdnUrls)
                                : QuillContentUtil.documentToContent(quillController.document);
                            ref.read(diaryProvider.notifier).setContent(contentJson);
                            ref.read(diaryProvider.notifier).setImage(cdnUrls);

                            var value = ref.read(diaryProvider);

                            if (widget.draftId != null) {
                              await viewModel.finalizeDraft(
                                  widget.draftId!, value, ref);
                            } else {
                              await viewModel.addDiaryPost(value, ref);
                            }

                            ref.invalidate(diaryListProvider);
                            ref.read(paginatedDiaryProvider.notifier).refresh();

                            try {
                              final diaries =
                                  await ref.read(diaryListProvider.future);
                              final profile = ref.read(profileProvider).value;
                              if (profile != null) {
                                await StreakService.updateWidgetData(
                                  diaries: diaries,
                                  profile: profile,
                                );
                              }
                            } catch (_) {}

                            if (!mounted) return;
                            PageRouter.router.go("/diary");
                          } catch (e) {
                            if (!mounted) return;
                            setState(() => _isSaving = false);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '일기 작성 중 오류가 발생했습니다: ${e.toString()}'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        },
                        text: "완료하기",
                      ),
                ),
              ),
            ],
          ),
        )));
  }
}
