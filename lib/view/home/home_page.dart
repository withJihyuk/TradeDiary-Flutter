import 'package:flutter/material.dart';
import 'package:trade_diary/view/components/box_widget.dart';
import 'package:trade_diary/view/components/box_widget_value.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFFF2F4F6),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Boxwidget(title: "오늘의 일기", children: [
                  Boxwidgetvalue(
                      title: "오늘의 일기",
                      subtitle: "오늘의 일기를 작성해보세요",
                      icon: Icons.book),
                ]),
              ])),
        )));
  }
}
