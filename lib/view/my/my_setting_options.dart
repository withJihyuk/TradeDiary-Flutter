part of 'my_page.dart';

class _MySettingOptions extends StatelessWidget {
  // ignore: unused_element
  const _MySettingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextSettingMenu(menuName: "감자 이름 변경", onPressed: () {}),
        SizedBox(height: 32.h),
        BoolSettingMenu(
          ischecked: false,
          menuName: "알림",
          onPressed: () {},
        ),
        SizedBox(height: 32.h),
        Container(
          decoration: const BoxDecoration(
            color: DiaryMainGrey.grey100,
          ),
          width: double.infinity,
          height: 1,
        ),
        SizedBox(height: 32.h),
        TextSettingMenu(menuName: "시스템", onPressed: () {}),
      ],
    );
  }
}
