import 'package:flutter/material.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class WritePage extends StatelessWidget {
  const WritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GlobalAppbar(title: "일기 쓰기"),
      body: Center(
        child: Text('WritePage'),
      ),
    );
  }
}
