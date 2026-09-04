part of 'diary_page.dart';

class _DiaryFloatingButton extends ConsumerWidget {
  const _DiaryFloatingButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayDiary = ref.watch(todayDiaryProvider);

    return FloatingActionButton(
        onPressed: () {
          if (todayDiary != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('오늘은 이미 일기를 작성했어요')),
            );
            return;
          }
          PageRouter.router.push("/write");
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1, color: DiaryColor.buttonSpecificColor),
            borderRadius: BorderRadius.circular(100)),
        backgroundColor: DiaryColor.globalMainColor,
        child: SvgPicture.asset(
          "assets/images/icons/edit.svg",
        ));
  }
}
