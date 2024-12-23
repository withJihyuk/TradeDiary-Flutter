part of 'my_page.dart';

class _MyHeader extends StatelessWidget {
  // ignore: unused_element
  const _MyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "마이",
          style: AppTextStyle.h4Semi,
        ),
        // GestureDetector(
        //   onTap: () => PageRouter.router.push("/alert"),
        //   child: SvgPicture.asset(
        //     "assets/images/icons/alert.svg",
        //   ),
        // )
      ],
    );
  }
}
