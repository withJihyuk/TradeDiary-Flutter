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
            const Text("페이지를 찾을 수 없어요"),
            const Text("사용자가 비공개 했거나 올바르지 않은 경로에요."),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: DiaryColorBlue.lightActive,
                  borderRadius: BorderRadius.circular(20)),
              child: const Text("메인으로 이동하기"),
            )
          ],
        ),
      ),
    );
  }
}
