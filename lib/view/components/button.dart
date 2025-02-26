import 'package:flutter/material.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';

class DiaryButton extends StatelessWidget {
  const DiaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = DiaryColor.globalMainColor,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 52,
    this.isDisabled = false,
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? DiaryMainGrey.grey300 : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: AppTextStyle.m2Semi.copyWith(
            color: isDisabled ? DiaryMainGrey.grey500 : textColor,
          ),
        ),
      ),
    );
  }
}
