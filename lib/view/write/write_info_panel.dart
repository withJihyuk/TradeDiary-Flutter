part of 'write_page.dart';

/// 본문 정보 패널 (글자수 모드, 시간)
class _InfoPanel extends ConsumerWidget {
  const _InfoPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quillController = ref.watch(quillControllerProvider);
    final plainText = quillController.document.toPlainText().trim();
    final writeStartTime = ref.watch(writeStartTimeProvider);
    final lastModifiedTime = ref.watch(lastModifiedTimeProvider);

    // 글자수 계산
    final charWithSpaces = plainText.length;
    final charWithoutSpaces = plainText.replaceAll(RegExp(r'\s'), '').length;
    final charPure = plainText
        .replaceAll(RegExp(r'[\s\p{P}\p{S}]', unicode: true), '')
        .length;

    final paragraphCount = plainText
        .split('\n')
        .where((l) => l.trim().isNotEmpty)
        .length;

    final timeFormat = DateFormat('a h:mm', 'ko_KR');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: DiaryMainGrey.grey50,
        border: Border(
          top: BorderSide(color: DiaryMainGrey.grey200, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _InfoRow(label: '글자 수', value: '$charWithSpaces (공백 포함)'),
          _InfoRow(label: '', value: '$charWithoutSpaces (공백 미포함)'),
          _InfoRow(label: '', value: '$charPure (공백·부호 미포함)'),
          const SizedBox(height: 4),
          _InfoRow(label: '문단', value: '$paragraphCount개'),
          const SizedBox(height: 4),
          if (writeStartTime != null)
            _InfoRow(
                label: '작성 시작', value: timeFormat.format(writeStartTime)),
          if (lastModifiedTime != null)
            _InfoRow(
                label: '마지막 수정',
                value: timeFormat.format(lastModifiedTime)),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTextStyle.labelRegular
                  .copyWith(color: DiaryMainGrey.grey500),
            ),
          ),
          Text(
            value,
            style: AppTextStyle.labelRegular
                .copyWith(color: DiaryMainGrey.grey800),
          ),
        ],
      ),
    );
  }
}
