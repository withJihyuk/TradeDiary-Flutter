import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const Text(
            '안녕, 세상!',
            style: TextStyle(fontFamily: "EF_Diary"),
          ),
          ElevatedButton(
            onPressed: () => context.push('/onBoarding'),
            child: const Text('온보딩', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () => context.push('/home'),
            child: const Text('온보딩', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    ));
  }
}
