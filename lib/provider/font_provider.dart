import 'package:flutter_riverpod/flutter_riverpod.dart';

const kFontMap = <String, String>{
  '프리텐다드': 'Pretendard',
  '일기체': 'EF_Diary',
};

final fontProvider = Provider<Map<String, String>>((ref) => kFontMap);
