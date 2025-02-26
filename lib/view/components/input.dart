import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';

class InputComponents extends StatelessWidget {
  const InputComponents(
      {super.key,
      required this.hintText,
      required this.isLong,
      required this.onChanged});
  final String hintText;
  final bool isLong;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        maxLines: isLong ? 10 : 1,
        maxLength: isLong ? 500 : 30,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          counterText: "",
          helperMaxLines: 94,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          disabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle:
              AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey600),
          filled: true,
          errorMaxLines: 10,
          fillColor: DiaryMainGrey.grey50,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  }
}
