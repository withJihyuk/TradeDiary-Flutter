import 'package:flutter/material.dart';

abstract class AppTextStyle {
  static TextStyle pretendardStyle(double size, double? height) => TextStyle(
        fontFamily: 'pretendard',
        leadingDistribution: TextLeadingDistribution.even,
        letterSpacing: 0,
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

  static final TextStyle labelRegular = pretendardRegularStyle(14, 21);
  static final TextStyle labelSemi = pretendardSemiBoldStyle(14, 21);
  static final TextStyle m3Regular = pretendardRegularStyle(14, 26.4);
  static final TextStyle m3Semi = pretendardSemiBoldStyle(14, 26.4);
  static final TextStyle m2Regular = pretendardRegularStyle(18, 27);
  static final TextStyle m2Semi = pretendardSemiBoldStyle(18, 27);
  static final TextStyle m1Regular = pretendardRegularStyle(20, 30);
  static final TextStyle m1Semi = pretendardSemiBoldStyle(20, 30);
  static final TextStyle h4Regular = pretendardRegularStyle(24, 31.2);
  static final TextStyle h4Semi = pretendardSemiBoldStyle(24, 31.2);
  static final TextStyle h3Regular = pretendardRegularStyle(28, 36.4);
  static final TextStyle h3Semi = pretendardSemiBoldStyle(28, 36.4);
  static final TextStyle h2Regular = pretendardRegularStyle(32, 38.4);
  static final TextStyle h2Semi = pretendardSemiBoldStyle(32, 38.4);
  static final TextStyle h1Regular = pretendardRegularStyle(36, 43.2);
  static final TextStyle h1Semi = pretendardSemiBoldStyle(36, 43.2);
}
