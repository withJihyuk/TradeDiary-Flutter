part of 'diary_page.dart';

class _DiaryFloatingButton extends ConsumerWidget {
  const _DiaryFloatingButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
        onPressed: () {
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
