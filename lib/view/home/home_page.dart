import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/provider/widget_update_provider.dart';
import 'package:trade_diary/util/level.dart';
import 'package:trade_diary/view/components/welcome_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    _checkFirstLogin();
  }

  Future<void> _checkFirstLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('has_seen_welcome') == true) return;

    await prefs.setBool('has_seen_welcome', true);

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const WelcomeDialog(),
    );
  }

  Widget _buildHeaderImages() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 38.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 213.w),
            child: Image.asset(
              "assets/images/character/sun.png",
              width: 132.w,
              height: 135.h,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/character/cloud.png",
              width: 102.w,
              height: 71.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelInfo(String nickname, int level, int earned, int target) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32.w, 280.h, 32.w, 28.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "LV.$level",
                    style: AppTextStyle.m2Semi.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    nickname,
                    style: AppTextStyle.m2Semi.copyWith(color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    target == 0 ? 'MAX' : earned.toString(),
                    style: AppTextStyle.labelRegular.copyWith(
                      color: DiaryColor.globalMainColor,
                    ),
                  ),
                  if (target > 0)
                    Text(
                      '/$target',
                      style: AppTextStyle.labelRegular.copyWith(
                        color: DiaryMainGrey.grey200,
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildExpProgressBar(target == 0 ? 1 : earned / target),
          SizedBox(height: 8.h),
          Text(
            "일기와 도전과제를 설정하면 감자가 성장해요",
            style: AppTextStyle.labelRegular.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildExpProgressBar(double progress) {
    return SizedBox(
      width: double.infinity,
      height: 12.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ColoredBox(
          color: DiaryMainGrey.grey300,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: const ColoredBox(color: DiaryColor.globalMainColor),
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterSection(ProfileModel profile) {
    final levels = LevelSystem();
    final level = levels.getLevel(profile.exp);
    final target = levels.expToNextLevel(profile.exp);
    final earned = (profile.exp - levels.getCurrentLevelExp(level)).clamp(
      0,
      target,
    );

    return Stack(
      children: [
        Positioned(
          top: 98.h,
          left: 0,
          right: 0,
          bottom: 0,
          child: const ColoredBox(color: Color(0xFF826A56)),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/character/img-potato-${level}lv.png',
            height: 164.h,
          ),
        ),
        _buildLevelInfo(profile.nickname, level, earned, target),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    ref.watch(widgetUpdateProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              DiaryColor.backgroundColor,
              DiaryColor.backgroundColor.withValues(alpha: 0.5),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeaderImages(),
              Expanded(
                child: profileState.when(
                  data: _buildCharacterSection,
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) =>
                      const Center(child: Text('오류가 발생했거나 연결에 문제가 있어요.')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
