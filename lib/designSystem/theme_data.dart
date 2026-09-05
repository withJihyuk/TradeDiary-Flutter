import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final customThemeData = ThemeData(
  appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Pretendard',
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF826A56),
    primary: const Color(0xFF826A56),
    surface: Colors.white,
    error: const Color(0xFFB33D32),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: const Color(0xFF51453D)),
  ),
  dialogTheme: DialogThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 6,
    shadowColor: const Color(0x18000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: Color(0xFFEBEBEB)),
    ),
  ),
);
