import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_diary/view/components/box_widget.dart';
import 'package:trade_diary/view/components/box_widget_value.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("교환일기",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            Row(children: [
              Icon(Icons.settings, size: 24, color: Colors.grey),
              SizedBox(width: 20),
              Icon(Icons.notifications, size: 24, color: Colors.grey)
            ])
          ],
        ),
        const SizedBox(height: 20),
        Column(children: [
          const Boxwidget(title: "오늘의 일기", children: [
            Boxwidgetvalue(
                title: "오늘의 일기", subtitle: "오늘의 일기를 작성해보세요", icon: Icons.book),
          ]),
          const SizedBox(height: 20),
          Boxwidget(title: "일기 교환", children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey),
            )
          ])
        ])
      ]),
    ))));
  }
}
