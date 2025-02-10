import 'package:flutter/material.dart';

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
      child: const Scaffold(
          backgroundColor: Colors.transparent, // 배경색을 투명으로 설정

          body: SafeArea(child: Text("테스트 ㅋㅋ"))),
    );
  }
}
