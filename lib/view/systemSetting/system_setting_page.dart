import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/view/components/setting_menu.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';
import 'package:trade_diary/viewModel/oauth_model.dart';
import 'package:trade_diary/service/notification_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemSettingPage extends StatefulWidget {
  const SystemSettingPage({super.key});

  @override
  State<SystemSettingPage> createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends State<SystemSettingPage> {
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              const TopNavigationBar(title: "시스템"),
              SizedBox(height: 40.h),
              // 알림 설정
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('일기 작성 알림', style: AppTextStyle.m3Regular),
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
              if (_notificationEnabled) ...[
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () async {
                    await NotificationService().showTestNotification();
                    if (mounted) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('테스트 알림을 전송했습니다. 알림이 오는지 확인해주세요.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '알림 테스트하기',
                    style: AppTextStyle.m3Regular.copyWith(
                      color: DiaryColor.globalMainColor,
                    ),
                  ),
                ),
              ],
              SizedBox(height: 20.h),
              // 기존 설정들
              TextSettingMenu(
                menuName: "이용약관",
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://working-mailman-871.notion.site/1685f20bda6f80de9e6fd71653317e55',
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              TextSettingMenu(
                menuName: "개인정보 처리방침",
                onPressed: () {
                  launchUrl(
                    Uri.parse(
                      'https://working-mailman-871.notion.site/1685f20bda6f80a3bc1fe4d5437772a7',
                    ),
                  );
                },
              ),
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () => oauthViewModel.logout(),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/icons/logout.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "로그아웃",
                      style: AppTextStyle.m3Regular.copyWith(
                        color: const Color(0xffCB1111),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () => PageRouter.router.push("/deleteId"),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/images/icons/user-exit.svg",
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "회원탈퇴",
                      style: AppTextStyle.m3Regular.copyWith(
                        color: const Color(0xffCB1111),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
