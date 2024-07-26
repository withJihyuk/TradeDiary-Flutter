import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('교환일기',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'EF_Diary',
                      color: Colors.black)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: 160,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE9F4EA),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text("일기 작성하기"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: 160,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEEEFE),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Text("일기 작성하기"),
                    )
                  ],
                ),
              ),
            ])),
      )),
    );
  }
}
