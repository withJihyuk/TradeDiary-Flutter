import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/view/components/box_widget.dart';
import 'package:trade_diary/view/components/box_widget_value.dart';
import 'package:trade_diary/view/components/post_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("교환일기",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        Row(children: [
                          Icon(Icons.settings, size: 24, color: Colors.grey),
                          SizedBox(width: 20),
                          Icon(Icons.notifications,
                              size: 24, color: Colors.grey)
                        ])
                      ],
                    ),
                    const SizedBox(height: 20),
                    Boxwidget(title: "캐릭터", children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                              onTap: () => context.push("/character"),
                              child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text("임시")])))
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      InkWell(
                          onTap: () => context.push("/write"),
                          child: const Boxwidget(title: "오늘의 일기", children: [
                            Boxwidgetvalue(
                                title: "작성하기",
                                subtitle: "오늘의 일기를 작성해보세요",
                                icon: Icons.book)
                          ])),
                      const SizedBox(height: 20),
                      Boxwidget(title: "일기 교환", children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () => context.push("/read"),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.network(
                                      "https://jjal.today/data/file/gallery/654777533_LXcuaI8Q_bc6f86a21271009c43de1783cb6780dc9e657a4d.jpeg"),
                                )),
                            const SizedBox(width: 20),
                            InkWell(
                                onTap: () => context.push("/read"),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.network(
                                      "https://jjal.today/data/file/gallery/654777533_LXcuaI8Q_bc6f86a21271009c43de1783cb6780dc9e657a4d.jpeg"),
                                )),
                            const SizedBox(width: 20),
                            InkWell(
                                onTap: () => context.push("/read"),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.network(
                                      "https://jjal.today/data/file/gallery/654777533_LXcuaI8Q_bc6f86a21271009c43de1783cb6780dc9e657a4d.jpeg"),
                                )),
                            const SizedBox(width: 20),
                            InkWell(
                                onTap: () => context.push("/read"),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.network(
                                      "https://jjal.today/data/file/gallery/654777533_LXcuaI8Q_bc6f86a21271009c43de1783cb6780dc9e657a4d.jpeg"),
                                )),
                            const SizedBox(
                                width: 20), // future builder 사용해야함 수정 필요
                            Icon(Icons.plus_one_rounded,
                                size: 20, color: Colors.grey[600]),
                          ],
                        )
                      ]),
                      const SizedBox(height: 20),
                      const Boxwidget(title: "커뮤니티", children: [
                        PostListWidget(postList: [
                          {'title': '나랑 일기 교환할래?', 'category': '구해요'},
                          {'title': '나 곱창 먹었는데 맛있겠징', 'category': '일상'},
                          {'title': '어떻게 하루종일 아프냐', 'category': '일상'},
                          {'title': '집가고싶다', 'category': '일상'},
                        ])
                      ])
                    ])
                  ]),
            ))));
  }
}
