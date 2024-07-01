import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            
            leadingWidth: 120,
            leading: const Text(
              '럭키비키',
              style: TextStyle(fontFamily: 'EF_Diary', fontSize: 30),
            )),
        body: const SafeArea(
          child: Column(
            children: [
              Text(
                '안녕, 세상!',
                style: TextStyle(fontFamily: "EF_Diary"),
              ),
            ],
          ),
        ));
  }
}
