import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/viewModel/oauth_model.dart';
import 'package:vibration/vibration.dart';

class SwipeGame extends StatefulWidget {
  const SwipeGame({super.key});

  @override
  State<SwipeGame> createState() => _SwipeGameState();
}

enum ItemType { grass, potato }

class _SwipeGameState extends State<SwipeGame> {
  bool isUp = false;
  ItemType currentItem = ItemType.grass;
  int points = 0;
  int hearts = 3;
  OauthViewModel oauthViewModel = OauthViewModel();

  void generateNextItem() {
    setState(() {
      currentItem = (DateTime.now().millisecondsSinceEpoch % 2 == 0)
          ? ItemType.grass
          : ItemType.potato;
    });
  }

  void handleSwipe(bool up) {
    bool success = (currentItem == ItemType.grass) ? up : !up;

    setState(() {
      if (success) {
        points += 10;
      } else {
        hearts -= 1;
      }
      isUp = false;
      points = 0;
    });

    if (hearts > 0) {
      generateNextItem();
    } else {
      showGameOverDialog();
    }
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white.withAlpha(80),
      builder: (_) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF9E836D),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: const Color(0xFF4A3C30),
              width: 1.w,
            ),
          ),
          height: 242.h,
          width: 295.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => context.go("/home"),
                child: Text("게임 나가기",
                    style: AppTextStyle.h4Semi.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 28.h),
              GestureDetector(
                onTap: () {
                  context.go("/swipeGameGuide1");
                },
                child: Text("가이드 다시보기",
                    style: AppTextStyle.h4Semi.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 28.h),
              GestureDetector(
                  onTap: () {
                    hearts = 3;
                    points = 0;
                    generateNextItem();
                    context.pop();
                  },
                  child: Image.asset("assets/images/icons/game-button.png")),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    generateNextItem();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/icons/swipe-game-background.png"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 42.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (index) => index + 1 > hearts
                        ? Image.asset(
                            "assets/images/character/heart-empty.png",
                            width: 72.w,
                            height: 60.h,
                          )
                        : Image.asset(
                            "assets/images/character/heart.png",
                            width: 72.w,
                            height: 60.h,
                          ),
                  ),
                ),
                SizedBox(height: 250.h),
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      isUp = details.localPosition.dy < 0; 
                    });
                  },
                  onVerticalDragEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dy < 0) {
                      // 위로 스와이프
                      _triggerVibration();
                      handleSwipe(true);
                    } else {
                      _triggerVibration();
                      handleSwipe(false);
                    }
                  },
                  child: Image.asset(
                    currentItem == ItemType.grass
                        ? isUp
                            ? "assets/images/character/grass_up.png"
                            : "assets/images/character/grass.png"
                        : "assets/images/character/potato-with-swipegame.png",
                    width: 158.w,
                    height: 223.h,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _triggerVibration() async {
  if (await Vibration.hasVibrator()) {
    Vibration.vibrate();
  }
}
