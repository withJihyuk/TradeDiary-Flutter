part of 'diary_page.dart';

class _DiaryFloatingButton extends StatelessWidget {
  // ignore: unused_element
  const _DiaryFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {},
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
