import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppFont {
  final String displayName;
  final String fontFamily;
  final bool isEnabled;

  const AppFont({
    required this.displayName,
    required this.fontFamily,
    this.isEnabled = true,
  });

  AppFont copyWith({bool? isEnabled}) =>
      AppFont(displayName: displayName, fontFamily: fontFamily, isEnabled: isEnabled ?? this.isEnabled);

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'fontFamily': fontFamily,
        'isEnabled': isEnabled,
      };

  factory AppFont.fromJson(Map<String, dynamic> json) => AppFont(
        displayName: json['displayName'] as String,
        fontFamily: json['fontFamily'] as String,
        isEnabled: json['isEnabled'] as bool? ?? true,
      );
}

const kBuiltInFonts = [
  AppFont(displayName: '프리텐다드', fontFamily: 'Pretendard'),
  AppFont(displayName: '일기체', fontFamily: 'EF_Diary'),
];

const _prefsKey = 'enabled_fonts';

class FontNotifier extends StateNotifier<List<AppFont>> {
  FontNotifier() : super(kBuiltInFonts) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_prefsKey);
    if (json != null) {
      final decoded = jsonDecode(json) as List;
      state = decoded.map((e) => AppFont.fromJson(e as Map<String, dynamic>)).toList();
    }
  }

  Future<void> toggle(String fontFamily) async {
    state = [
      for (final f in state)
        if (f.fontFamily == fontFamily) f.copyWith(isEnabled: !f.isEnabled) else f,
    ];
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(state.map((e) => e.toJson()).toList()));
  }

  /// 에디터 툴바용: 활성화된 폰트만 {displayName: fontFamily} Map 반환
  Map<String, String> get enabledFontMap => {
        for (final f in state)
          if (f.isEnabled) f.displayName: f.fontFamily,
      };
}

final fontProvider = StateNotifierProvider<FontNotifier, List<AppFont>>((ref) {
  return FontNotifier();
});
