import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            onPressed: () => context.go('/onBoarding'),
            child: const Text('온보딩', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () => context.go('/onBoarding'),
            child: const Text('온보딩', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    ));
  }
}
