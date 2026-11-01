import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trade_diary/designSystem/fontsize.dart';

class TextSettingMenu extends StatelessWidget {
  const TextSettingMenu({
    super.key,
    required this.menuName,
    required this.onPressed,
  });
  final String menuName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(menuName, style: AppTextStyle.m3Regular),
          SvgPicture.asset(
            "assets/images/icons/arrow-right.svg",
            width: 24.w,
            height: 24.h,
          ),
        ],
      ),
    );
  }
}
