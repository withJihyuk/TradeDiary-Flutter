import 'package:flutter/material.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          const SizedBox(height: 40),
          const Text(
            "럭키비키",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'EF_Diary', fontSize: 38, height: 1.2),
          ),
          const SizedBox(height: 4),
          const Text(
            "남들과 함께 하여 더 즐겁게 일기를 써봐요 ",
            style: TextStyle(fontSize: 18),
          ),
          SvgPicture.asset(
            'assets/images/hamster.svg',
            width: 500,
            height: 500,
          ),
          const SizedBox(height: 20),
          const Button(
            buttonName: '시작하기',
            route: '/login',
            isRoute: true,
          ),
        ])))));
  }
}
