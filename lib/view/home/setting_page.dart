import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/util/screen_size.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppbar(title: "설정"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("이지혁",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600)),
                      Text("s23066@gsm.hs.kr",
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700])),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: GetMediaQuery.getScreenWidth(context),
              height: 30,
              color: Colors.grey[300],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("일반"),
                      const SizedBox(height: 20),
                      InkWell(
                        child:
                            const Text("알림 관리", style: TextStyle(fontSize: 20)),
                        onTap: () => context.push("/"),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child: const Text("데이터 관리",
                            style: TextStyle(fontSize: 20)),
                        onTap: () => context.push("/"),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child:
                            const Text("잠금 설정", style: TextStyle(fontSize: 20)),
                        onTap: () => context.push("/"),
                      ),
                      const SizedBox(height: 50),
                      const Text("서비스 정보"),
                      const SizedBox(height: 20),
                      InkWell(
                        child:
                            const Text("이용 약관", style: TextStyle(fontSize: 20)),
                        onTap: () => context.push("/"),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child: const Text("개인정보 처리방침",
                            style: TextStyle(fontSize: 20)),
                        onTap: () => context.push("/"),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child: const Text("버전 정보 0.0.1",
                            style: TextStyle(fontSize: 20)),
                        onTap: () => context.push("/"),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child:
                            const Text("로그아웃", style: TextStyle(fontSize: 20)),
                        onTap: () => context.push("/"),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
