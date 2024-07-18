import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('교환일기',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'EF_Diary',
                      color: Colors.black)),
            ])),
      )),
    );
  }
}
