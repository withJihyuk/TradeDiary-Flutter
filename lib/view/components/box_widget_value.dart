import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';

class Boxwidgetvalue extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const Boxwidgetvalue(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: DiaryColorBlue.normal),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18))
              ],
            )
          ],
        ));
  }
}
