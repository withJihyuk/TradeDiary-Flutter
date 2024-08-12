import 'package:flutter/material.dart';
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
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(26),
                      width: 390,
                      height: 200,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: const Column(children: [Text("안녕하세요")]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      const Boxwidget(title: "오늘의 일기", children: [
                        Boxwidgetvalue(
                            title: "작성하기",
                            subtitle: "오늘의 일기를 작성해보세요",
                            icon: Icons.book),
                      ]),
                      const SizedBox(height: 20),
                      Boxwidget(title: "일기 교환", children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                            ),
                            const SizedBox(width: 20),
                            Icon(Icons.plus_one_rounded,
                                size: 24, color: Colors.grey[400]),
                          ],
                        )
                      ]),
                      const SizedBox(height: 20),
                      const Boxwidget(title: "커뮤니티", children: [
                        PostListWidget(postList: [
                          {'title': '나랑 일기 교환할래?', 'category': '구해요'},
                          {'title': '나 곱창 먹었는데 맛있겠징', 'category': '일상'},
                        ])
                      ])
                    ])
                  ]),
            ))));
  }
}
