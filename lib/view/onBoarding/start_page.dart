import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/util/screen_size.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 여기도 마진 변경 필요. 각 디바이스마다 버튼의 위치 차이가 너무 심함.

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
          const SizedBox(height: 80),
          const Text(
            "감자일기",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'EF_Diary', fontSize: 38, height: 1.2),
          ),
          const SizedBox(height: 4),
          const Text(
            "감자와 함께 일기를 써봐요!",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: GetMediaQuery.getScreenHeight(context) / 6),
          Image.asset(
              width: 150,
              height: 150,
              "assets/images/character/img-potato-7lv.png"),
          SizedBox(height: GetMediaQuery.getScreenHeight(context) / 9),
          TextButton(
            onPressed: () => context.push('/login'),
            child: Container(
                alignment: Alignment.center,
                width: GetMediaQuery.getScreenWidth(context) * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  '시작하기',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ])))));
  }
}
