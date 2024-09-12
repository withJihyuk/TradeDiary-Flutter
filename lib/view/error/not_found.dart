import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                    width: 60,
                    height: 60,
                    'assets/images/character/img-potato-sad.png'),
                const SizedBox(height: 10),
                const Text("정보를 불러올 수 없어요",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () => context.push("/home"),
                    child: Container(
                      alignment: Alignment.center,
                      width: 140,
                      height: 48,
                      decoration: BoxDecoration(
                          color: DiaryColorBlue.normal,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text("홈으로 이동하기",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ))
              ],
            ),
          ),
        ));
  }
}
