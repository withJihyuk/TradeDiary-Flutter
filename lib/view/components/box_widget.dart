import 'package:flutter/material.dart';

class Boxwidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const Boxwidget({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenPadding = MediaQuery.of(context).padding.horizontal + 28;

    return Container(
        padding: const EdgeInsets.all(26),
        width: screenWidth - screenPadding,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey,
                )
              ],
            ),
            const SizedBox(height: 22),
            Column(
              children: children,
            ),
          ],
        ));
  }
}
