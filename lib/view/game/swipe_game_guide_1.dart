import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/view/game/swipe_game.dart';

class SwipeGameGuide1 extends StatelessWidget {
  const SwipeGameGuide1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => context.push('/swipeGameGuide2'),
      child: Stack(
        children: [
          const SwipeGame(),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(204),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80.h,
                ),
                Image.asset("assets/images/icons/game-02.png",
                    width: 200.w, height: 96.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("assets/images/character/grass.png",
                        width: 158.w, height: 223.h),
                    Lottie.asset('assets/images/animation/up_animation.json'),
                  ],
                ),
                SizedBox(height: 84.h),
                Text("잡초는 위로 스와이프 해서 뽑고",
                    style: AppTextStyle.m1Semi.copyWith(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
