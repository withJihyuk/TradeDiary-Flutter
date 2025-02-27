part of 'my_page.dart';

class _MySettingOptions extends StatelessWidget {
  const _MySettingOptions();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextSettingMenu(
            menuName: "감자 이름 변경",
            onPressed: () => PageRouter.router.push("/nickname")),
        // SizedBox(height: 32.h),
        // BoolSettingMenu(
        //   ischecked: false,
        //   menuName: "알림",
        //   onPressed: () {},
        // ),
        SizedBox(height: 32.h),
        Container(
          decoration: const BoxDecoration(
            color: DiaryMainGrey.grey100,
          ),
          width: double.infinity,
          height: 1,
        ),
        SizedBox(height: 32.h),
        TextSettingMenu(
            menuName: "시스템",
            onPressed: () => PageRouter.router.push("/systemSetting")),
      ],
    );
  }
}
