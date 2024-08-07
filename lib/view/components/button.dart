import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Button extends StatelessWidget {
  final String buttonName;
  final String route;
  final bool isRoute;
  const Button(
      {super.key,
      required this.buttonName,
      required this.route,
      required this.isRoute});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        isRoute ? context.go(route) : print('입력됨');
      }, //context.go('/onBoarding')
      style: TextButton.styleFrom(
        minimumSize: const Size(200, 50), // 버튼 크기
        padding: const EdgeInsets.all(10), // 패딩
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      child: Text(
        buttonName,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
