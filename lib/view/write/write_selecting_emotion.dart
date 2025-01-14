import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/provider/diary.dart';
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
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNavigationBar(title: "감정 선택"),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "감정선택",
                style: AppTextStyle.m3Regular
                    .copyWith(color: DiaryMainGrey.grey800),
              ),
              SizedBox(
                height: 12.h,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: Emotion.emotionMap.keys.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final emotionName =
                        Emotion.emotionMap.keys.elementAt(index);
                    final emotionImage = Emotion.emotionMap[emotionName]!;

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
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: DiaryColor.globalMainColor,
                                      width: 2))
                              : BoxDecoration(
                                  color: DiaryMainGrey.grey50,
                                  borderRadius: BorderRadius.circular(8)),
                          child: Image.asset(emotionImage,
                              width: 100.w, height: 100.h),
                        ));
                  }),
              SizedBox(
                height: 145.h,
              ),
              Button(
                  onPressed: () {
                    final value = ref.read(diaryProvider);
                    viewModel.addDiaryPost(value);
                    PageRouter.router.go("/diary");
                  },
                  text: "완료하기")
            ],
          )),
    ));
  }
}
