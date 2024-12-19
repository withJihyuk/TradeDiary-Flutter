part of 'todo_page.dart';

class _TodoFloatingButton extends StatelessWidget {
  // ignore: unused_element
  const _TodoFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
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
