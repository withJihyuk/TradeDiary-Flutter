import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/util/screen_size.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

const snackBar = SnackBar(
  content: Text('아직 준비중인 기능입니다.\n준비되면 알려 드릴게요!'),
);

class MyCharacter extends StatelessWidget {
  const MyCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppbar(title: "캐릭터"),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                height: 300,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: DiaryColor.globalColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.fullscreen),
                            ))),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "캐릭터 이미지",
                        style: TextStyle(),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(children: [
                          InkWell(
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar),
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.shopping_bag),
                              )),
                          const SizedBox(
                            width: 18,
                          ),
                          InkWell(
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar),
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.backpack_rounded),
                              )),
                        ]))
                  ],
                )),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 60,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.water_drop,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text("50",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500))
                                        ])),
                                const SizedBox(width: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 30,
                                        width: 60,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                        child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.sunny,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text("50",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ]))
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text("생후 200일 감자"),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "귀염둥이우리애",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Container(
                              height: 30,
                              width: 48,
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius: BorderRadius.circular(14)),
                              child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("레어",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600))
                                  ]),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: GetMediaQuery.getScreenWidth(context),
                          decoration: BoxDecoration(
                              color: DiaryColorBlue.lightActive,
                              borderRadius: BorderRadius.circular(14)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("감자를 더 꾸며주고 싶다면?",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400)),
                                  Text("감자를 클릭해 보세요",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.ads_click,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                      ],
                    )))
          ],
        )),
      ),
    );
  }
}
