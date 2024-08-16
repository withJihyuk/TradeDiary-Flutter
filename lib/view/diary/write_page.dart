import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class WritePage extends StatelessWidget {
  const WritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppbar(
        title: "일기쓰기",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: DiaryColorBlue.lightHover,
                    ),
                    child: const Text(
                      "일상",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "8월 15일",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    fontFamily: "EF_Diary"),
              ),
              const SizedBox(
                height: 12,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "오늘은 어떤 일이 있으셨나요?\n자유롭게 일기를 작성해봐요!",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 18),
                maxLines: 20,
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        color: DiaryColorBlue.lightActive,
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.brush),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
