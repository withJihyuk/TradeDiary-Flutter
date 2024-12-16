import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static TextStyle pretendardStyle(double size, double? height) => TextStyle(
        fontFamily: 'Pretendard',
        fontSize: size,
        height: height,
      );

  static TextStyle pretendardRegularStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w400,
      );

  static TextStyle pretendardSemiBoldStyle(double size, double? height) =>
      pretendardStyle(size, height).copyWith(
        fontWeight: FontWeight.w600,
      );

  static final TextStyle labelRegular = pretendardRegularStyle(14, 1.5);
  static final TextStyle labelSemi = pretendardSemiBoldStyle(14, 1.5);
  static final TextStyle m3Regular = pretendardRegularStyle(16, 1.65);
  static final TextStyle m3Semi = pretendardSemiBoldStyle(16, 1.65);
  static final TextStyle m2Regular = pretendardRegularStyle(18, 1.5);
  static final TextStyle m2Semi = pretendardSemiBoldStyle(18, 1.5);
  static final TextStyle m1Regular = pretendardRegularStyle(20, 1.5);
  static final TextStyle m1Semi = pretendardSemiBoldStyle(20, 1.5);
  static final TextStyle h4Regular = pretendardRegularStyle(24, 1.3);
  static final TextStyle h4Semi = pretendardSemiBoldStyle(24, 1.3);
  static final TextStyle h3Regular = pretendardRegularStyle(28, 1.3);
  static final TextStyle h3Semi = pretendardSemiBoldStyle(28, 1.3);
  static final TextStyle h2Regular = pretendardRegularStyle(32, 1.2);
  static final TextStyle h2Semi = pretendardSemiBoldStyle(32, 1.2);
  static final TextStyle h1Regular = pretendardRegularStyle(36, 1.2);
  static final TextStyle h1Semi = pretendardSemiBoldStyle(36, 1.2);

  static const bottomLabelStyle = TextStyle(
    fontFamily: "Pretendard",
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w400,
  );
}
