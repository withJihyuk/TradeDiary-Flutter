import 'package:flutter/material.dart';

import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final TextEditingController controller = TextEditingController();

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
              const Text(
                "8월 22일",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    fontFamily: "EF_Diary"),
              ),
              const SizedBox(
                height: 10,
              ),
              // SplittedMarkdownFormField
              MarkdownAutoPreview(
                cursorColor: DiaryColorBlue.lightActive,
                toolbarBackground: DiaryColorBlue.light,
                expandableBackground: DiaryColorBlue.lightActive,
                hintText: "오늘은 어떤 일이 있으셨나요?\n자유롭게 일기를 작성해봐요!",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: "입력하기",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
                controller: controller,
                emojiConvert: true,
                showEmojiSelection: true,
              ),

              // TextField(
              //   decoration: InputDecoration(
              //     hintText: "오늘은 어떤 일이 있으셨나요?\n자유롭게 일기를 작성해봐요!",
              //     hintStyle: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.grey[500],
              //     ),
              //     border: InputBorder.none,
              //   ),
              //   style: const TextStyle(fontSize: 18),
              //   maxLines: 20,
              // ),
            ],
          ),
        )),
      ),
      bottomNavigationBar: BottomAppBar(
        color: DiaryColorBlue.lightActive,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: () {
                controller.text += "![image](https://picsum.photos/200/300)";
              },
            ),
            IconButton(
              icon: const Icon(Icons.brush),
              onPressed: () {},
            ),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                print(controller.value.toJSON());
              },
            ),
          ],
        ),
      ),
    );
  }
}
