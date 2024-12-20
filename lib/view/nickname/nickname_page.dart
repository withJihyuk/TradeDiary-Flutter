import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/input.dart';

class NicknamePage extends StatelessWidget {
  const NicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Text('감자 이름을 정해주세요!'),
          SizedBox(
            height: 80.h,
          ),
          const InputComponents(hintText: "이름을 입력해주세요"),
          SizedBox(
            height: 400.h,
          ),
          Button(onPressed: () {}, text: "확인")
        ],
      )),
    );
  }
}
