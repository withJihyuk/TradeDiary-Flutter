part of 'todo_page.dart';

class _TodoHeader extends StatelessWidget {
  // ignore: unused_element
  const _TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "도전과제",
          style: AppTextStyle.h4Semi,
        ),
        // SvgPicture.asset(
        //   "assets/images/icons/menu.svg",
        // ),
      ],
    );
  }
}
