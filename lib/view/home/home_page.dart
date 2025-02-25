import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/util/level.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Widget _buildHeaderImages() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 38.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.push("/swipeGame"),
                child: Image.asset(
                  "assets/images/icons/game-01.png",
                  width: 160.w,
                  height: 82.h,
                ),
              ),
              Image.asset(
                "assets/images/icons/game-02.png",
                width: 160.w,
                height: 82.h,
              ),
            ],
          ),
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

  Widget _buildLevelInfo(ProfileModel profile) {
    final levelSystem = LevelSystem();
    final currentLevel = levelSystem.getLevel(profile.exp);
    final nextLevelExp = levelSystem.expToNextLevel(profile.exp);

    return Padding(
      padding: EdgeInsets.fromLTRB(32.w, 210.h, 32.w, 38.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "LV.$currentLevel",
                    style: AppTextStyle.m2Semi.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    profile.nickname,
                    style: AppTextStyle.m2Semi.copyWith(color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    profile.exp.toString(),
                    style: AppTextStyle.labelRegular.copyWith(
                      color: DiaryColor.globalMainColor,
                    ),
                  ),
                  Text(
                    '/$nextLevelExp',
                    style: AppTextStyle.labelRegular.copyWith(
                      color: DiaryMainGrey.grey200,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildExpProgressBar(profile, nextLevelExp),
          SizedBox(height: 8.h),
          Text(
            "일기와 도전과제를 설정하면 감자가 성장해요",
            style: AppTextStyle.labelRegular.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildExpProgressBar(ProfileModel profile, int nextLevelExp) {
    return SizedBox(
      width: double.infinity,
      height: 12.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Flexible(
              flex: profile.exp,
              child: Container(color: DiaryColor.globalMainColor),
            ),
            Flexible(
              flex: nextLevelExp - profile.exp,
              child: Container(color: DiaryMainGrey.grey300),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterSection(String characterImagePath) {
    return Stack(
      children: [
        Positioned(
          top: 98.h,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(color: Color(0xFF826A56)),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            characterImagePath,
            height: 164.h,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

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
              profileState.when(
                data: (profile) {
                  final levelSystem = LevelSystem();
                  final currentLevel = levelSystem.getLevel(profile.exp);
                  final characterImagePath =
                      "assets/images/character/img-potato-${currentLevel}lv.png";

                  return Expanded(
                    child: Stack(
                      children: [
                        _buildCharacterSection(characterImagePath),
                        _buildLevelInfo(profile),
                      ],
                    ),
                  );
                },
                loading: () => const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stackTrace) => const Expanded(
                  child: Center(
                    child: Text('오류가 발생했거나 연결에 문제가 있어요.'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
