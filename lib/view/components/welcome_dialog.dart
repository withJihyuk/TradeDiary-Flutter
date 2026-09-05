import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_widget/home_widget.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/service/notification_service.dart';
import 'package:trade_diary/view/components/button.dart';

class WelcomeDialog extends StatefulWidget {
  const WelcomeDialog({super.key});

  @override
  State<WelcomeDialog> createState() => _WelcomeDialogState();
}

class _WelcomeDialogState extends State<WelcomeDialog> {
  bool _notificationEnabled = false;
  bool _widgetEnabled = false;

  Future<void> _onConfirm() async {
    if (_notificationEnabled) {
      await NotificationService().setNotificationEnabled(true);
    }
    if (_widgetEnabled) {
      if (Platform.isAndroid) {
        await HomeWidget.requestPinWidget(
          qualifiedAndroidName: 'com.jihyuk.potatodiary.PotatoDiaryWidget',
        );
      }
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '감자일기에 오신 걸\n환영합니다!',
            textAlign: TextAlign.center,
            style: AppTextStyle.m1Semi.copyWith(color: DiaryMainGrey.grey900),
          ),
          SizedBox(height: 12.h),
          Text(
            '더 편리하게 사용하기 위해\n아래 설정을 추천드려요.',
            textAlign: TextAlign.center,
            style: AppTextStyle.m3Regular.copyWith(
              color: DiaryMainGrey.grey700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildCheckTile(
            value: _notificationEnabled,
            label: '매일 일기 작성 알림 받기',
            onChanged: (v) => setState(() => _notificationEnabled = v ?? false),
          ),
          _buildCheckTile(
            value: _widgetEnabled,
            label: '홈 화면에 위젯 추가하기',
            onChanged: (v) => setState(() => _widgetEnabled = v ?? false),
          ),
          if (_widgetEnabled && Platform.isIOS) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: DiaryMainGrey.grey50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '홈 화면 길게 누르기 > 좌측 상단 + 버튼 > "감자일기" 검색',
                style: AppTextStyle.labelRegular.copyWith(
                  color: DiaryMainGrey.grey700,
                ),
              ),
            ),
          ],
          SizedBox(height: 20.h),
          DiaryButton(onPressed: _onConfirm, text: '시작하기'),
        ],
      ),
    );
  }

  Widget _buildCheckTile({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: DiaryColor.globalMainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: AppTextStyle.m3Regular.copyWith(
                color: DiaryMainGrey.grey800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
