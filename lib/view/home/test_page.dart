import 'package:flutter/material.dart';

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                const Text(
                  "벌써 200일째",
                  style: TextStyle(color: Color(0xF0777777), fontSize: 24),
                ),
                const Text("지혁님의 당당한감자",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  width: 60,
                  padding: const EdgeInsets.all(4)
                      .add(const EdgeInsets.symmetric(vertical: 4)),
                  decoration: const BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("🥔 20")],
                  ),
                ),
                Stack(

                  children: [
                    Positioned(
                      bottom: 200,
                      child:
                    Image.asset(
                      'assets/images/character/img-potato-1lv.png',
                    ),),
                    Image.asset(
                      'assets/images/character/background.png',
                    ),

                  ],
                )
              ],
            )),
      ),
      bottomNavigationBar: BottomAppBar(

        child: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.home,size: 30,)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.book, size: 30,)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, size: 30,)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings, size: 30,))
          ],
        ),
      ))
    );
  }
}
