import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '안녕, 세상!',
          style: TextStyle(fontFamily: "EF_Diary"),
        ),
      ),
    );
  }
}
