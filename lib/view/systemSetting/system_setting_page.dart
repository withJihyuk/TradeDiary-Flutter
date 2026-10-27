import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/service/draft_store.dart';
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

class SystemSettingPage extends ConsumerStatefulWidget {
  const SystemSettingPage({super.key});

  @override
  ConsumerState<SystemSettingPage> createState() => _SystemSettingPageState();
}

class _SystemSettingPageState extends ConsumerState<SystemSettingPage> {
  bool _notificationEnabled = false;
  TimeOfDay? _notificationTime;
  bool _settingNotification = false;
  bool _notificationChanged = false;
  final OauthViewModel oauthViewModel = OauthViewModel();

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {
    final enabled = await NotificationService().isNotificationEnabled();
    final time = await NotificationService().getNotificationTime();
    if (!mounted) return;
    setState(() {
      _notificationTime = time;
      if (!_notificationChanged) _notificationEnabled = enabled;
    });
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? '오전' : '오후';
    return '$period $hour:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickNotificationTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime ?? const TimeOfDay(hour: 20, minute: 0),
    );
    if (picked == null || !mounted) return;
    try {
      await NotificationService().setNotificationTime(picked);
      if (mounted) setState(() => _notificationTime = picked);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('알림 시간을 저장하지 못했어요')));
      }
    }
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
                    onChanged: _settingNotification
                        ? null
                        : (value) async {
                            setState(() {
                              _settingNotification = true;
                              _notificationChanged = true;
                            });
                            try {
                              final applied = await NotificationService()
                                  .setNotificationEnabled(value);
                              if (!mounted) return;
                              if (applied) {
                                setState(() => _notificationEnabled = value);
                              } else {
                                _showPermissionDeniedDialog();
                              }
                            } catch (_) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('알림 설정을 저장하지 못했어요'),
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() => _settingNotification = false);
                              }
                            }
                          },
                  ),
                ],
              ),
              if (_notificationEnabled) ...[
                SizedBox(height: 20.h),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _pickNotificationTime,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('알림 시간', style: AppTextStyle.m3Regular),
                      Text(
                        _notificationTime == null
                            ? ''
                            : _formatTime(_notificationTime!),
                        style: AppTextStyle.m3Regular.copyWith(
                          color: DiaryColor.globalMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () async {
                    try {
                      await NotificationService().showTestNotification();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('테스트 알림을 전송했어요')),
                        );
                      }
                    } catch (_) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('테스트 알림을 보내지 못했어요. 알림 권한을 확인해 주세요'),
                          ),
                        );
                      }
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
                onTap: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('로그아웃할까요?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('취소'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('로그아웃'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed != true) return;
                  try {
                    await ref.read(draftStoreProvider).flush();
                    await oauthViewModel.logout();
                  } catch (_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('로그아웃하지 못했어요. 저장 상태와 연결을 확인해 주세요'),
                        ),
                      );
                    }
                  }
                },
                child: Row(
                  children: [
                    SizedBox.square(
                      dimension: 24.w,
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/images/icons/logout.svg",
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "로그아웃",
                      style: AppTextStyle.m3Regular.copyWith(
                        color: DiaryColor.errorColor,
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
                      height: 24.w,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "회원탈퇴",
                      style: AppTextStyle.m3Regular.copyWith(
                        color: DiaryColor.errorColor,
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
