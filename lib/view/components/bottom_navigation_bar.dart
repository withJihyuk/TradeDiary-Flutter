import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/router.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.child});
  final Widget child;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    switch (index) {
      case 0:
        PageRouter.router.go('/home');
        break;
      case 1:
        PageRouter.router.go('/groups');
        break;
      case 2:
        PageRouter.router.go('/archive');
        break;
      case 3:
        PageRouter.router.go('/my');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.child,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: DiaryMainGrey.grey100, width: 1))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onDestinationSelected,
            enableFeedback: false,
            unselectedLabelStyle: AppTextStyle.bottomLabelStyle.copyWith(
              color: DiaryMainGrey.grey600,
            ),
            selectedLabelStyle: AppTextStyle.bottomLabelStyle.copyWith(
              color: DiaryColor.globalMainColor,
            ),
            fixedColor: DiaryColor.globalMainColor,
            currentIndex: selectedIndex,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SvgPicture.asset(
                        (selectedIndex == 0)
                            ? "assets/images/icons/home-fill.svg"
                            : "assets/images/icons/home-border.svg",
                      )),
                  label: '홈'),
              const BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Icon(Icons.groups_outlined),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Icon(Icons.groups),
                  ),
                  label: '그룹'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SvgPicture.asset(
                        (selectedIndex == 2)
                            ? "assets/images/icons/diary-fill.svg"
                            : "assets/images/icons/diary-border.svg",
                      )),
                  label: '보관함'),
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: SvgPicture.asset(
                        (selectedIndex == 3)
                            ? "assets/images/icons/my-fill.svg"
                            : "assets/images/icons/my-border.svg",
                      )),
                  label: '마이'),
            ],
          ),
        ));
  }
}
