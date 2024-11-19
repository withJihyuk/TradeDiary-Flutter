import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:go_router/go_router.dart';
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
              isPreview
                  ? MarkdownAutoPreview(
                      controller: controller,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: "내용을 작성 해주세요.",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: 100,
                    ) // 스타일 수정 필요
                  : MarkdownField(
                      padding: const EdgeInsets.all(0),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      controller: controller,
                      maxLines: 100,
                      readOnly: isPreview ? true : false,
                      decoration: const InputDecoration(
                        hintText: "여기를 눌러 오늘의 일기를 작성해주세요",
                        hintStyle: TextStyle(
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
            IconButton(
              icon: const Icon(Icons.photo),
              onPressed: () async {
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);
                final imageID = await diaryPostViewModel.uploadImage(image!);
                controller.text +=
                    "![Github_Logo](https://152.70.37.62:9000/profile-images/${imageID.fileName}.webp";
              },
            ), // 이미지 추가용
            // IconButton(
            //   icon: const Icon(Icons.brush),
            //   onPressed: () {},
            // ), // 배경용
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
                  });
                }),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                diaryPostViewModel.addDiaryPost(
                  controller.text,
                  isPrivate,
                );
                context.push('/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
