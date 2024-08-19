import 'package:flutter/material.dart';

class CloseUp extends StatelessWidget {
  final String? id;
  const CloseUp({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("CloseUp Page, $id"),
      ),
    );
  }
}
