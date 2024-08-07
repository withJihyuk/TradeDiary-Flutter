import 'package:flutter/material.dart';

class GlobalAppbar extends StatelessWidget {
  final String title;
  final bool isBack;
  const GlobalAppbar({super.key, required this.title, required this.isBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: isBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}