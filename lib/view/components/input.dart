import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';

class InputComponents extends StatelessWidget {
  InputComponents({super.key, required this.hintText});
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
      disabledBorder: InputBorder.none,
      hintText: hintText,
      hintStyle: AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey600),
      filled: true,
      fillColor: DiaryMainGrey.grey50,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    ));
  }
}
