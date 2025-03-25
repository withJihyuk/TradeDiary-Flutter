import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/game/swipe_game.dart';

class SwipeGameGuide3 extends StatelessWidget {
  const SwipeGameGuide3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const SwipeGame(),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(204),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80.h,
              ),
              Image.asset("assets/images/icons/game-02.png",
                  width: 200.w, height: 96.h),
              SizedBox(height: 175.h),
              Image.asset("assets/images/character/heart.png",
                  width: 120.w, height: 100.h),
              SizedBox(height: 163.h),
              Text("3번 틀리면 탈락!",
                  style: AppTextStyle.m1Semi.copyWith(color: Colors.white)),
              SizedBox(height: 28.h),
              SizedBox(
                  width: 350.w,
                  child: DiaryButton(
                      text: "시작하기", onPressed: () => context.go('/swipeGame'))),
              SizedBox(
                height: 18.h,
              ),
              GestureDetector(
                onTap: () => context.go('/swipeGameGuide1'),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("다시보기",
                      style:
                          AppTextStyle.m3Regular.copyWith(color: Colors.white)),
                  SvgPicture.asset("assets/images/icons/repeat.svg")
                ]),
              )
            ],
          ),
        )
      ],
    ));
  }
}
