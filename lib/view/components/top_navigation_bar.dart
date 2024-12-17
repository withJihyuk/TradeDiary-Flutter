import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/router.dart';

class TopNavigationBar extends StatelessWidget {
  TopNavigationBar({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () => PageRouter.router.pop(),
            child: SvgPicture.asset(
              "assets/images/icons/arrow.svg",
            )),
        Text(
          title,
          style: AppTextStyle.m2Semi,
        ),
        const SizedBox(
          width: 24,
          height: 24,
        ),
      ],
    );
  }
}
