part of 'my_page.dart';

class _MySettingOptions extends StatefulWidget {
  const _MySettingOptions();

  @override
  State<_MySettingOptions> createState() => __MySettingOptionsState();
}

class __MySettingOptionsState extends State<_MySettingOptions> {
  bool _notificationEnabled = false;
  final OauthViewModel oauthViewModel = OauthViewModel();

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {
    final enabled = await NotificationService().isNotificationEnabled();
    setState(() {
      _notificationEnabled = enabled;
    });
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알림 권한 필요'),
        content: const Text('일기 작성 알림을 받으려면 알림 권한이 필요합니다. 설정에서 알림 권한을 허용해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '확인',
              style: AppTextStyle.m3Regular.copyWith(
                color: DiaryColor.globalMainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
