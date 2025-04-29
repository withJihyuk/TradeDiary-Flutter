import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/game/swipe_game.dart';
import 'package:trade_diary/view/game/swipe_game_guide_1.dart';

class SwipeGameGuide3 extends StatefulWidget {
  const SwipeGameGuide3({super.key});

  @override
  State<SwipeGameGuide3> createState() => _SwipeGameGuide3State();
}

class _SwipeGameGuide3State extends State<SwipeGameGuide3> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      // 게임 화면의 이미지 프리로드
      precacheImage(const AssetImage("assets/images/character/grass.png"), context);
      precacheImage(const AssetImage("assets/images/character/potato-with-swipegame.png"), context);
      _isInitialized = true;
    }
  }

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
                      text: "시작하기", 
                      onPressed: () => Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const SwipeGame(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        ),
                      ))),
              SizedBox(
                height: 18.h,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const SwipeGameGuide1(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  ),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("다시보기",
                      style: AppTextStyle.m3Regular.copyWith(color: Colors.white)),
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
