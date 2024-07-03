import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leadingWidth: 200,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/settings');
            },
            icon: const Icon(Icons.notifications_none_rounded),
          )
        ],
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            '럭키비키',
            style: TextStyle(fontFamily: 'EF_Diary', fontSize: 30),
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [],
        )),
      ),
    );
  }
}
