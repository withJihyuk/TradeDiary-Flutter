import 'package:flutter/material.dart';
import 'package:trade_diary/util/screen_size.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = GetMediaQuery.getScreenWidth(context);
    var screenHeight = GetMediaQuery.getScreenHeight(context);

    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
          children: [
            SizedBox(height: screenHeight/12,),
            const Text(
              "벌써 200일째",
              style: TextStyle(color: Color(0xF0777777), fontSize: 24),
            ),
            const Text("지혁님의 당당한감자",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: const Center(child: Text("🥔 20"),
              ),
            ),
            const CharacterSection()
          ],
        )),
        bottomNavigationBar: const BottomAppBarTest());
  }
}

class BottomAppBarTest extends StatelessWidget {
  const BottomAppBarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.book,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                size: 30,
              ))
        ],
      ),
    ));
  }
}

class CharacterSection extends StatelessWidget {
  const CharacterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/character/background.png",
          fit: BoxFit.fill,
        ),
        Positioned(
            top: 285,
            child: Image.asset(
              "assets/images/character/img-potato-1lv.png",
              width: 150,
              height: 150,
            )) // 이미지 크기를 동적으로 계산 하여 재배치 할 필요가 있어요.
      ],
    );
  }
}
