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
                            "럭키비키 이용자라면?",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 14),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: '이메일',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: '비밀번호',
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {
                                    print('입력됨');
                                  }, //context.go('/onBoarding')
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(200, 50), // 버튼 크기
                                    padding: const EdgeInsets.all(10), // 패딩
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                  ),
                                  child: const Text(
                                    '로그인하기',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.go('/register');
                                  },
                                  child: const Text(
                                    '아직이면? 회원가입 하기',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ])))));
  }
}
