import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: const Text(
            '로그인',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          const Text(
                            "로그인 해주세요",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 14),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                InkWell(
                                    onTap: () => context.go("/home"),
                                    child: Container(
                                        padding: const EdgeInsets.all(20),
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white),
                                        child: Row(children: [
                                          Image.asset(
                                            'assets/images/google.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                          const SizedBox(width: 20),
                                          const Text("Google로 계속하기 ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600))
                                        ]))),
                                const SizedBox(height: 8),
                                InkWell(
                                    onTap: () => context.go("/home"),
                                    child: Container(
                                        padding: const EdgeInsets.all(20),
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.white),
                                        child: Row(children: [
                                          Image.asset(
                                            'assets/images/apple.png',
                                            width: 40,
                                            height: 40,
                                          ),
                                          const SizedBox(width: 20),
                                          const Text("Apple로 계속하기",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600))
                                        ])))
                              ],
                            ),
                          ),
                        ])))));
  }
}