import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';

class Boxwidgetvalue extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isicon;
  final String? assetname;
  final IconData? icon;

  const Boxwidgetvalue(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.isicon,
      this.assetname,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            isicon
                ? Icon(icon, size: 40, color: DiaryColorBlue.normal)
                : Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!, width: 2),
                        shape: BoxShape.circle),
                    child: Image.asset(
                      assetname!,
                    ),
                  ),
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
