part of 'write_page.dart';

// ─── 색상 피커 ───

Future<void> _showColorPicker(
  BuildContext context,
  WidgetRef ref,
  QuillController controller,
  bool isBackground,
) async {
  final Color? picked = await showModalBottomSheet<Color>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _ColorPickerSheet(isBackground: isBackground),
  );

  if (!context.mounted) return;
  if (picked == null) return;

  // 배경 없음 / 기본 색상 → 속성 제거
  if (isBackground && picked == Colors.transparent) {
    final attr = Attribute.clone(Attribute.background, null);
    controller.formatSelection(attr);
    _rememberInlineIntent(ref, controller, attr);
    return;
  }
  if (!isBackground && picked == Colors.black) {
    final attr = Attribute.clone(Attribute.color, null);
    controller.formatSelection(attr);
    _rememberInlineIntent(ref, controller, attr);
    return;
  }

  ref.read(recentColorsProvider.notifier).add(picked);
  if (isBackground) {
    ref.read(frequentBackgroundColorsProvider.notifier).record(picked);
  } else {
    ref.read(frequentTextColorsProvider.notifier).record(picked);
  }

  final hex =
      '#${picked.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
  if (isBackground) {
    final attr = BackgroundAttribute(hex);
    controller.formatSelection(attr);
    _rememberInlineIntent(ref, controller, attr);
  } else {
    final attr = ColorAttribute(hex);
    controller.formatSelection(attr);
    _rememberInlineIntent(ref, controller, attr);
  }
}

// ─── 색상 파싱 헬퍼 ───

Color? _parseHexColor(dynamic value) {
  if (value == null) return null;
  if (value is! String) return null;
  try {
    final hex = value.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  } catch (_) {
    return null;
  }
}

// ─── 자주 쓰는 색상 ───

const _frequentColors = [
  Colors.black,
  Color(0xFF555555),
  Color(0xFF999999),
  Color(0xFFCCCCCC),
  Color(0xFFE57373),
  Color(0xFFFF8A65),
  Color(0xFFFFB74D),
  Color(0xFFFFD54F),
  Color(0xFF81C784),
  Color(0xFF4DB6AC),
  Color(0xFF4DD0E1),
  Color(0xFF64B5F6),
  Color(0xFF7986CB),
  Color(0xFF9575CD),
  Color(0xFFBA68C8),
  Color(0xFFF06292),
  Color(0xFFE0A98F),
  Color(0xFFD8A980),
  Color(0xFFA1887F),
  Colors.white,
];

// 배경색: 미리보기(진한) → 실제 적용(연한)
const _bgColorPreviews = [
  Color(0xFFF48FB1), // 분홍
  Color(0xFFFFAB91), // 주황
  Color(0xFFFFE082), // 노랑
  Color(0xFFC5E1A5), // 연두
  Color(0xFFA5D6A7), // 초록
  Color(0xFF80CBC4), // 틸
  Color(0xFF80DEEA), // 시안
  Color(0xFF90CAF9), // 파랑
  Color(0xFF9FA8DA), // 남색
  Color(0xFFB39DDB), // 보라
  Color(0xFFCE93D8), // 자주
  Color(0xFFFFAB91), // 코랄
  Color(0xFFBCAAA4), // 베이지
  Color(0xFFD7CCC8), // 모카
  Color(0xFFB0BEC5), // 그레이블루
  Color(0xFFEEEEEE), // 흰색
];

const _bgColorActuals = [
  Color(0xFFFCE4EC), // 연분홍
  Color(0xFFFFF3E0), // 연주황
  Color(0xFFFFFDE7), // 연노랑
  Color(0xFFF1F8E9), // 연연두
  Color(0xFFE8F5E9), // 연초록
  Color(0xFFE0F2F1), // 연틸
  Color(0xFFE0F7FA), // 연시안
  Color(0xFFE3F2FD), // 연파랑
  Color(0xFFE8EAF6), // 연남색
  Color(0xFFEDE7F6), // 연보라
  Color(0xFFF3E5F5), // 연자주
  Color(0xFFFBE9E7), // 연코랄
  Color(0xFFEFEBE9), // 연베이지
  Color(0xFFF5F0EB), // 연모카
  Color(0xFFECEFF1), // 연그레이블루
  Colors.white,
];

const _kFrequentTextColorsStorageKey = 'write.frequent_text_colors.v1';
const _kFrequentBackgroundColorsStorageKey = 'write.frequent_bg_colors.v1';
const _kFrequentColorCapacity = 20;

String _colorToStorageHex(Color color) {
  return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';
}

Color _backgroundPreviewForActual(Color actual) {
  final index = _bgColorActuals.indexWhere(
    (c) => c.toARGB32() == actual.toARGB32(),
  );
  if (index >= 0) return _bgColorPreviews[index];
  return actual;
}

class FrequentColorsNotifier extends StateNotifier<List<Color>> {
  FrequentColorsNotifier({
    required this.storageKey,
    required List<Color> fallback,
  }) : _fallback = List<Color>.from(fallback),
       super(List<Color>.from(fallback)) {
    _restore();
  }

  final String storageKey;
  final List<Color> _fallback;
  bool _recordedSinceInit = false;

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey);
    if (raw == null || raw.isEmpty) return;

    final restored = <Color>[];
    for (final item in raw) {
      final parsed = _parseHexColor(item);
      if (parsed != null) restored.add(parsed);
    }

    if (_recordedSinceInit) return;
    if (restored.isEmpty) {
      state = List<Color>.from(_fallback);
      return;
    }
    state = restored.take(_kFrequentColorCapacity).toList();
  }

  Future<void> record(Color color) async {
    _recordedSinceInit = true;
    final updated = [
      color,
      ...state.where((c) => c.toARGB32() != color.toARGB32()),
    ].take(_kFrequentColorCapacity).toList();
    state = updated;

    final prefs = await SharedPreferences.getInstance();
    final serialised = updated.map(_colorToStorageHex).toList();
    await prefs.setStringList(storageKey, serialised);
  }
}

class RecentColorsNotifier extends StateNotifier<List<Color>> {
  RecentColorsNotifier() : super([]);

  void add(Color color) {
    final updated = [
      color,
      ...state.where((c) => c.toARGB32() != color.toARGB32()),
    ];
    state = updated.take(10).toList();
  }
}

final recentColorsProvider =
    StateNotifierProvider<RecentColorsNotifier, List<Color>>((ref) {
      return RecentColorsNotifier();
    });

final frequentTextColorsProvider =
    StateNotifierProvider<FrequentColorsNotifier, List<Color>>((ref) {
      return FrequentColorsNotifier(
        storageKey: _kFrequentTextColorsStorageKey,
        fallback: _frequentColors,
      );
    });

final frequentBackgroundColorsProvider =
    StateNotifierProvider<FrequentColorsNotifier, List<Color>>((ref) {
      return FrequentColorsNotifier(
        storageKey: _kFrequentBackgroundColorsStorageKey,
        fallback: _bgColorActuals,
      );
    });

class _ColorPickerSheet extends ConsumerWidget {
  const _ColorPickerSheet({required this.isBackground});

  final bool isBackground;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentColors = ref.watch(recentColorsProvider);
    final frequentColors = isBackground
        ? ref.watch(frequentBackgroundColorsProvider)
        : ref.watch(frequentTextColorsProvider);
    final frequentDisplayColors = isBackground
        ? frequentColors
              .map(_backgroundPreviewForActual)
              .toList(growable: false)
        : frequentColors;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isBackground ? '배경 색상' : '글자 색상', style: AppTextStyle.m2Semi),
          if (recentColors.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              '최근 사용한 색',
              style: AppTextStyle.labelRegular.copyWith(
                color: DiaryMainGrey.grey500,
              ),
            ),
            const SizedBox(height: 8),
            _ColorGrid(
              colors: recentColors,
              onSelect: (c) => Navigator.of(context).pop(c),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            '자주 쓰는 색',
            style: AppTextStyle.labelRegular.copyWith(
              color: DiaryMainGrey.grey500,
            ),
          ),
          const SizedBox(height: 8),
          _ColorGrid(
            colors: frequentDisplayColors,
            actualColors: isBackground ? frequentColors : null,
            onSelect: (c) => Navigator.of(context).pop(c),
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: () =>
                  Navigator.of(context)
                      .pop(isBackground ? Colors.transparent : Colors.black),
              child: Text(
                isBackground ? '배경 없음' : '기본 색상으로',
                style: AppTextStyle.labelRegular.copyWith(
                  color: DiaryMainGrey.grey700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  const _ColorGrid({
    required this.colors,
    required this.onSelect,
    this.actualColors,
  });
  final List<Color> colors;
  final List<Color>? actualColors;
  final ValueChanged<Color> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(colors.length, (i) {
        final displayColor = colors[i];
        final returnColor = actualColors?[i] ?? displayColor;
        return GestureDetector(
          onTap: () => onSelect(returnColor),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: displayColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: displayColor.computeLuminance() > 0.9
                    ? DiaryMainGrey.grey300
                    : Colors.transparent,
                width: 1,
              ),
            ),
          ),
        );
      }),
    );
  }
}
