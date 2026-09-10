import 'package:flutter_riverpod/flutter_riverpod.dart';

const kFontMap = <String, String>{'프리텐다드': 'Pretendard', '고운돋움': 'GowunDodum'};

final fontProvider = Provider<Map<String, String>>((ref) => kFontMap);
