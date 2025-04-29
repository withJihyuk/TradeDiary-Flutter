import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/view/game/swipe_game.dart';
import 'package:trade_diary/view/game/swipe_game_guide_3.dart';

class SwipeGameGuide2 extends StatefulWidget {
  const SwipeGameGuide2({super.key});

  @override
  State<SwipeGameGuide2> createState() => _SwipeGameGuide2State();
}

class _SwipeGameGuide2State extends State<SwipeGameGuide2> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      // 다음 화면의 이미지 프리로드
      precacheImage(const AssetImage("assets/images/character/heart.png"), context);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SwipeGame(),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const SwipeGameGuide3(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(204),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 80.h),
                  Image.asset(
                    "assets/images/icons/game-02.png",
                    width: 200.w,
                    height: 96.h,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/images/character/potato-with-swipegame.png",
                        width: 158.w,
                        height: 223.h,
                      ),
                      Lottie.asset('assets/images/animation/down_animation.json'),
                    ],
                  ),
                  SizedBox(height: 84.h),
                  Text(
                    "감자는 아래로 스와이프 해서 넘기기",
                    style: AppTextStyle.m1Semi.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
