import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const GlobalAppbar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              context.pop();
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ));
  }
}
