import 'package:flutter/material.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: GlobalAppbar(
          title: "안녕",
        ),
        body: SafeArea(
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
