import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/router.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key, required this.title, this.onBack});
  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          tooltip: '뒤로 가기',
          onPressed:
              onBack ??
              () {
                if (PageRouter.router.canPop()) {
                  PageRouter.router.pop();
                } else {
                  PageRouter.router.go('/home');
                }
              },
          icon: SvgPicture.asset("assets/images/icons/arrow.svg"),
        ),
        Text(title, style: AppTextStyle.m2Semi),
        const SizedBox(width: 48, height: 48),
      ],
    );
  }
}
