import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/character/img-potato-7lv.png",
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
