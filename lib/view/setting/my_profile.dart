import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  final String id;
  const MyProfile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(id)),
    );
  }
}
