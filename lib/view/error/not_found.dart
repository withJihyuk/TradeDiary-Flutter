import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppbar(title: "오류"),
      body: Center(
        child: Column(
          children: [
            Image.asset(width: 60, height: 60, 'assets/images/dw.png'),
            const SizedBox(height: 10),
            const Text("정보를 불러올 수 없어요",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 48,
              decoration: BoxDecoration(
                  color: DiaryColorBlue.normal,
                  borderRadius: BorderRadius.circular(8)),
              child: const Text("홈으로 이동하기",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
    );
  }
}
