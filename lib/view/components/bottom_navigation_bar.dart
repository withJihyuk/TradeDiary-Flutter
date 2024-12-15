import 'package:flutter/material.dart';
import 'package:trade_diary/router.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.child});
  final Widget child;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        PageRouter.router.go('/todo');
        break;
      case 1:
        PageRouter.router.go('/board');
        break;
      case 2:
        PageRouter.router.go('/my');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(label: 'Todo', icon: Icon(Icons.check_circle)),
          NavigationDestination(label: 'Board', icon: Icon(Icons.dashboard)),
          NavigationDestination(label: 'My', icon: Icon(Icons.person)),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
