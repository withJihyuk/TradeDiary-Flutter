import 'package:flutter/material.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "지혁이의 일기",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: const SafeArea(
          child: Column(
            children: [
              Text(
                "Read Page",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
