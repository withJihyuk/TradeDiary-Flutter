import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenPadding = MediaQuery.of(context).padding.horizontal + 28;

    return Scaffold(
        backgroundColor: const Color(0xFFF2F4F6),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.all(26),
                    width: screenWidth - screenPadding,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "오늘의 일기",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_month,
                                    size: 40, color: Colors.blueAccent),
                                SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("2021년 10월 10일",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey)),
                                    Text("오늘의 일기가 없습니다.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18))
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )),
                const SizedBox(height: 20),
                Container(
                    padding: const EdgeInsets.all(26),
                    width: screenWidth - screenPadding,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "칭찬스티커",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ],
                    )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.all(20),
                //       width: screenWidth / 2 - screenPadding,
                //       height: 80,
                //       decoration: const BoxDecoration(
                //         color: Color(0xFFE9F4EA),
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //       ),
                //       child: const Text("일기 작성하기"),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.all(20),
                //       width: screenWidth / 2 - screenPadding,
                //       height: 80,
                //       decoration: const BoxDecoration(
                //         color: Color(0xFFEEEEFE),
                //         borderRadius: BorderRadius.all(Radius.circular(10)),
                //       ),
                //       child: const Text("일기 작성하기"),
                //     )
                //   ],
                // )
              ])),
        )));
  }
}
