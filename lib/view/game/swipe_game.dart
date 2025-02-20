import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwipeGame extends StatelessWidget {
  const SwipeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/icons/swipe-game-background.png",
              ))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 42.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/character/heart.png",
                      width: 72.w,
                      height: 60.h,
                    ),
                    Image.asset(
                      "assets/images/character/heart.png",
                      width: 72.w,
                      height: 60.h,
                    ),
                    Image.asset(
                      "assets/images/character/heart.png",
                      width: 72.w,
                      height: 60.h,
                    ),
                  ],
                ),
                SizedBox(height: 308.h),
                Image.asset(
                  "assets/images/icons/swipe-game.png",
                  width: 320.w,
                  height: 320.h,
                ),
              ],
            ),
          ))),
    );
  }
}
