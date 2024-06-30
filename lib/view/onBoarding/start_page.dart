import 'package:flutter/material.dart';
import 'package:trade_diary/view/components/button.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "럭키\n비키",
        style: TextStyle(fontFamily: 'EF_Diary', fontSize: 38, height: 1.2),
      ),
      SizedBox(height: 4),
      Text(
        "여러 사람들과 함께 일기를 교환해봐요",
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 20),
      Button(
        buttonName: '시작하기',
        route: '/login',
        isRoute: true,
      ),
      SizedBox(height: 8),
    ])));
  }
}
