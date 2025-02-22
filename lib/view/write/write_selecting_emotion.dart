import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/provider/diary_image.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/write_diary.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/util/emotion.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

class WriteSelectingEmotion extends ConsumerWidget {
  const WriteSelectingEmotion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = DiaryViewModel();
    var selectedEmotion = ref.watch(diaryProvider).emotion;

    return Scaffold(
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
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 30,
                                crossAxisSpacing: 30,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final emotionName = Emotion.emotionMap.keys.elementAt(index);
                                final emotionImage = Emotion.emotionMap[emotionName]!;

                                return GestureDetector(
                                  onTap: () {
                                    ref.read(diaryProvider.notifier).setEmotion(emotionName);
                                  },
                                  child: Container(
                                    width: 160.w,
                                    height: 160.h,
                                    padding: const EdgeInsets.all(30),
                                    decoration: (selectedEmotion == emotionName)
                                        ? BoxDecoration(
                                            color: const Color(0xFFF5E0CE),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(
                                                color: DiaryColor.globalMainColor,
                                                width: 2))
                                        : BoxDecoration(
                                            color: DiaryMainGrey.grey50,
                                            borderRadius: BorderRadius.circular(8)),
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
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Button(
                    onPressed: () async {
                      try {
                        var value = ref.read(diaryProvider);
                        final imageFiles = ref.read(diaryImageProvider);
                        List<String> imagePaths =
                            imageFiles.map((file) => file.path).toList();

                        debugPrint('시작: 일기 작성 시도');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('일기를 저장하는 중입니다...'),
                            duration: Duration(seconds: 1),
                          ),
                        );

                        debugPrint('이미지 경로: $imagePaths');
                        if (imagePaths.isNotEmpty) {
                          final uploadedUrls =
                              await viewModel.uploadImage(imagePaths);
                          ref.read(diaryProvider.notifier).setImage(uploadedUrls);
                          value = ref.read(diaryProvider);
                        }

                        await viewModel.addDiaryPost(value);

                        ref.invalidate(diaryListProvider);
                        PageRouter.router.go("/diary");
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('일기 작성 중 오류가 발생했습니다: ${e.toString()}'),
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
        ));
  }
}
