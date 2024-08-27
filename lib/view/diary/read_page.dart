import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/view/components/global_appbar.dart';
import 'package:trade_diary/view/components/user_box.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

class ReadPage extends StatelessWidget {
  final String id;
  const ReadPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    DiaryPostViewModel viewModel = DiaryPostViewModel();
    viewModel.getDiaryPost(id).then((value) {
      controller.text += value[0]['content'];
    });

    // 프로필 기능 제작 시, 프로필 가져오기와 팔로우 기능 제작 필요
    // 잘못된 페이지 id 파라미터가 들어오면, 에러 페이지로 라우팅 제작 필요
    // 무조건적으로 오늘 날짜 가져오는 문제 함수 형태로 데이터 넘기고 parse 하여 해결하기

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const GlobalAppbar(
          title: "일기",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          viewModel.getTodayDate(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              fontFamily: "EF_Diary"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MarkdownField(
                      padding: const EdgeInsets.all(0),
                      controller: controller,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      maxLines: 100,
                      readOnly: true,
                    ),
                  ])),
        )));
  }
}
