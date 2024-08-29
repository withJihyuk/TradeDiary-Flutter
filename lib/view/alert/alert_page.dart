import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/util/screen_size.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppbar(title: "알림"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: GetMediaQuery.getScreenWidth(context),
              height: 120,
              decoration:
                  const BoxDecoration(color: DiaryColorBlue.lightActive),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        color: Colors.grey[400], shape: BoxShape.circle),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "캐릭터 안내",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      const Text("캐릭터가 기다리고 있어요!\n바로 돌아와서 돌봐주세요",
                          style: TextStyle(fontSize: 15)),
                      const SizedBox(height: 2),
                      Text(
                        "2일전",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
