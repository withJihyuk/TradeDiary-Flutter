import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/view/components/global_appbar.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final TextEditingController controller = TextEditingController();
  final DiaryPostViewModel diaryPostViewModel = DiaryPostViewModel();
  final userId = Supabase.instance.client.auth.currentUser!.id;

  var isPrivate = true;
  var isPreview = false;

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
              Text(
                diaryPostViewModel.getTodayDate(),
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    fontFamily: "EF_Diary"),
              ),
              const SizedBox(
                height: 10,
              ),
              MarkdownField(
                padding: const EdgeInsets.all(0),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                controller: controller,
                maxLines: 100,
                readOnly: isPreview ? true : false,
                decoration: InputDecoration(
                  hintText:
                      isPreview ? "아직 내용이 작성되지 않았어요" : "여기를 눌러 오늘의 일기를 작성해주세요",
                  hintStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                ),
              )
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
            // IconButton(
            //   icon: const Icon(Icons.photo),
            //   onPressed: () {
            //     controller.text += "![image](https://picsum.photos/200/300)";
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.brush),
            //   onPressed: () {},
            // ),
            IconButton(
                icon: isPrivate
                    ? const Icon(Icons.lock)
                    : const Icon(Icons.lock_open),
                onPressed: () {
                  setState(() {
                    isPrivate = !isPrivate;
                  });
                }),
            IconButton(
                icon: isPreview
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.remove_red_eye_outlined),
                onPressed: () {
                  setState(() {
                    isPreview = !isPreview;
                    print(isPreview);
                  });
                }),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                diaryPostViewModel.addDiaryPost(
                  controller.text,
                  isPrivate,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
