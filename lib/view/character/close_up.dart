import 'package:flutter/material.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class CloseUp extends StatelessWidget {
  final String? id;
  const CloseUp({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppbar(title: "확대"),
      body: Center(
        child: Text("$id\n준비중이에요"),
      ),
    );
  }
}
