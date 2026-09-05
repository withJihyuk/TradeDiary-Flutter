part of 'diary_page.dart';

class _Header extends ConsumerWidget {
  const _Header();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(draftStoreProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('일기', style: AppTextStyle.h4Semi),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: DiaryMainGrey.grey900,
            backgroundColor: DiaryMainGrey.grey50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          onPressed: () {
            store.refresh();
            PageRouter.router.push('/drafts');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.drafts_outlined,
                size: 18,
                color: DiaryMainGrey.grey800,
              ),
              const SizedBox(width: 6),
              Text('임시저장', style: AppTextStyle.labelRegular),
              if (store.drafts.isNotEmpty) ...[
                const SizedBox(width: 6),
                Text(
                  '${store.drafts.length}',
                  style: AppTextStyle.labelSemi.copyWith(
                    color: DiaryMainGrey.grey900,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
