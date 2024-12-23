import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class DiarySelectingEmotion extends StatelessWidget {
  const DiarySelectingEmotion({super.key});

  @override
  Widget build(BuildContext context) {
    final emotionList = [
      {"image": "assets/images/character/img-potato-sad.png", "name": "슬픈감자"},
      {"image": "assets/images/character/img-potato-rich.png", "name": "부자감자"},
      {
        "image": "assets/images/character/img-potato-hungry.png",
        "name": "배고픈감자"
      },
    ];

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
                  itemCount: emotionList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 160.w,
                      height: 160.h,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: DiaryMainGrey.grey50,
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset(emotionList[index]["image"]!,
                          width: 100.w, height: 100.h),
                    );
                  }),
              SizedBox(
                height: 145.h,
              ),
              Button(onPressed: () {}, text: "완료하기")
            ],
          )),
    ));
  }
}
