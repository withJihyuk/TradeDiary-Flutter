import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key, required this.currentIndex});
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        index = currentIndex;
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded), label: 'mypage'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'menu'),
      ],
    );
  }
}
