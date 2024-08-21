import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/util/screen_size.dart';
import 'package:trade_diary/view/components/global_appbar.dart';
import 'package:trade_diary/view/components/user_box.dart';

class ReadPage extends StatelessWidget {
  final String? id;

  const ReadPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const GlobalAppbar(
          title: "안녕",
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UserBox(
                        name: "이지혁",
                        description: "소통해요~",
                        imageUrl: "https://picsum.photos/200"),
                    Text(
                      "팔로우",
                      style: TextStyle(
                          fontSize: 18,
                          color: DiaryColorBlue.normal,
                          fontWeight: FontWeight.w500),
                    )
                  ]),
              const SizedBox(
                height: 24,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "8월 19일",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        fontFamily: "EF_Diary"),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "오늘 야채곱창을 먹었는데 기분이 넘 좋았다. 베라도 조졌는데 진짜 최고였음 ㅇㅇ 싱글벙글~ 아 글고 일기도 이렇게 쓰니깐 완전 갓생같잖아~",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Image.network(
                "https://picsum.photos/200/300",
                width: GetMediaQuery.getScreenWidth(context),
              ),
            ],
          ),
        ))));
  }
}
