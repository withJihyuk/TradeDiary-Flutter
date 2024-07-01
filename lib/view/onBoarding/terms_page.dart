import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            "환영합니다!\n이용약관에 동의해주세요.",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 14),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [],
                            ),
                          ),
                        ])))));
    // 라우터를 이용한 뒤로가기 제어 필요
    // 약관 제작 필요
  }
}
