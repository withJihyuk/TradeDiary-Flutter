import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/view/components/box_widget.dart';
import 'package:trade_diary/view/components/box_widget_value.dart';
import 'package:trade_diary/viewModel/home_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isWriteDiary = false;
  String? diaryId;
  Future? _future;

  HomeViewModel viewModel = HomeViewModel();
  Future checkDiary() async {
    await viewModel.isUserWriteDiaryToday().then((value) {
      setState(() {
        if (value != false) {
          isWriteDiary = !isWriteDiary;
          diaryId = value['id'];
        }
      });
    });
  }

  @override
  void initState() {
    _future = checkDiary();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DiaryColor.globalColor,
        body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("교환일기",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600)),
                        Row(children: [
                          InkWell(
                            onTap: () => context.push("/setting"),
                            child: const Icon(Icons.settings,
                                size: 24, color: Colors.grey),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                              onTap: () => context.push("/alert"),
                              child: const Icon(Icons.notifications,
                                  size: 24, color: Colors.grey))
                        ])
                      ],
                    ),
                    const SizedBox(height: 20),
                    Boxwidget(title: "캐릭터", children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                              onTap: () => context.push("/character"),
                              child: const Boxwidgetvalue(
                                  title: "보러가기",
                                  subtitle: "캐릭터가 기다리고 있어요",
                                  isicon: false,
                                  assetname: "assets/images/hamster.svg")))
                    ]),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      Boxwidget(title: "일기 작성", children: [
                        FutureBuilder(
                            future: _future,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return isWriteDiary
                                  ? InkWell(
                                      onTap: () =>
                                          context.push("/read/$diaryId"),
                                      child: const Boxwidgetvalue(
                                        title: "작성완료",
                                        subtitle: "오늘은 일기를 작성 했어요",
                                        isicon: true,
                                        icon: Icons.check,
                                      ))
                                  : InkWell(
                                      onTap: () {
                                        context.push("/write");
                                      },
                                      child: const Boxwidgetvalue(
                                        title: "작성하기",
                                        subtitle: "오늘의 일기를 작성해보세요",
                                        isicon: true,
                                        icon: Icons.book,
                                      ));
                            })
                      ]),
                      const SizedBox(height: 20),
                      Boxwidget(title: "일기 교환", children: [
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () => context.push("/read/1"),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2,
                                            color: DiaryColorBlue.normal),
                                      ),
                                      child: Image.network(
                                          fit: BoxFit.fill,
                                          "https://jjal.today/data/file/gallery/654777533_LXcuaI8Q_bc6f86a21271009c43de1783cb6780dc9e657a4d.jpeg"),
                                    )),
                                const SizedBox(
                                    width: 20), // future builder 사용해야함 수정 필요
                                Icon(Icons.plus_one_rounded,
                                    size: 20, color: Colors.grey[600]),
                              ],
                            ))
                      ]),
                    ])
                  ]),
            ))));
  }
}
