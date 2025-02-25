import 'package:flutter/material.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: DiaryColor.globalMainColor,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(text,
              style: AppTextStyle.m2Semi.copyWith(color: Colors.white)),
        ));
  }
}
