import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/util/screen_size.dart';
import 'package:trade_diary/view/components/box_widget_value.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

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
                    const SizedBox(
                      height: 20,
                    ),
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
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.shopping_bag),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.backpack_rounded),
                          ),
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
                            Container(
                                height: 30,
                                width: 60,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(14)),
                                child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  fontWeight: FontWeight.w500))
                                        ]))
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Text("지혁 💕감자"),
                        const Text(
                          "벌써 태어난지 200일",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("어쩌구저쩌구")
                      ],
                    )))
          ],
        )),
      ),
    );
  }
}
