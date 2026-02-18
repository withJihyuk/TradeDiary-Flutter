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
        SizedBox(height: 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '일기 작성 알림',
              style: AppTextStyle.m3Regular,
            ),
            CupertinoSwitch(
              value: _notificationEnabled,
              activeTrackColor: DiaryColor.globalMainColor,
              onChanged: (value) async {
                if (value) {
                  final service = NotificationService();
                  final hasPermission = await service.checkPermissions();
                  if (!hasPermission) {
                    _showPermissionDeniedDialog();
                    return;
                  }
                }
                await NotificationService().setNotificationEnabled(value);
                setState(() {
                  _notificationEnabled = value;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 28.h),
        Container(
          decoration: const BoxDecoration(
            color: DiaryMainGrey.grey100,
          ),
          width: double.infinity,
          height: 1,
        ),
        SizedBox(height: 28.h),
        TextSettingMenu(
            menuName: "시스템",
            onPressed: () => PageRouter.router.push("/systemSetting")),
      ],
    );
  }
}
