import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';

class TextSettingMenu extends StatelessWidget {
  const TextSettingMenu(
      {super.key, required this.menuName, required this.onPressed});
  final String menuName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              menuName,
              style: AppTextStyle.m3Regular,
            ),
            SvgPicture.asset(
              "assets/images/icons/arrow-right.svg",
              width: 24.w,
              height: 24.h,
            )
          ],
        ));
  }
}

class BoolSettingMenu extends StatefulWidget {
  const BoolSettingMenu({
    super.key,
    required this.menuName,
    required this.ischecked,
    required this.onPressed,
  });

  final String menuName;
  final bool ischecked;
  final VoidCallback onPressed;

  @override
  State<BoolSettingMenu> createState() => _BoolSettingMenuState();
}

class _BoolSettingMenuState extends State<BoolSettingMenu> {
  late bool isSwitchChecked;

  @override
  void initState() {
    super.initState();
    isSwitchChecked = widget.ischecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.menuName,
            style: AppTextStyle.m3Regular,
          ),
          CupertinoSwitch(
            value: isSwitchChecked,
            activeTrackColor: DiaryColor.globalMainColor,
            onChanged: (value) {
              setState(() {
                isSwitchChecked = value; // Update local state
              });
              widget.onPressed(); // Call the onPressed callback
            },
          ),
        ],
      ),
    );
  }
}
