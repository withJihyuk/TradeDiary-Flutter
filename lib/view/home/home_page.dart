import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/provider/widget_update_provider.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/util/level.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/welcome_dialog.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  static const _ink = Color(0xFF51453D);
  static const _muted = Color(0xFF887D72);

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

  Widget _character(ProfileModel profile, bool completed) {
    final levels = LevelSystem();
    final level = levels.getLevel(profile.exp);
    final target = levels.expToNextLevel(profile.exp);
    final earned = (profile.exp - levels.getCurrentLevelExp(level)).clamp(
      0,
      target,
    );
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            completed ? '오늘도 이야기해 줘서 고마워' : '네 이야기를 기다리고 있어',
            style: AppTextStyle.labelRegular.copyWith(color: _muted),
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/character/img-potato-${level}lv.png',
          height: 180,
          width: 260,
          fit: BoxFit.contain,
          semanticLabel: '${profile.nickname} 감자',
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE4D8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Lv. $level',
                style: AppTextStyle.labelSemi.copyWith(
                  color: _ink,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                profile.nickname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.m2Semi.copyWith(color: _ink),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 220,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: target == 0 ? 1 : earned / target,
              minHeight: 5,
              color: DiaryColor.buttonSpecificColor,
              backgroundColor: const Color(0xFFE8DFD3),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          target == 0 ? '어느새 이렇게 자랐어요' : '다음 성장까지 일기 ${target - earned}편',
          style: AppTextStyle.labelRegular.copyWith(
            color: _muted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider);
    final today = ref.watch(koreanDayProvider);
    final diary = ref.watch(todayDiaryProvider);
    final diaries = ref.watch(diaryListProvider);
    ref.watch(widgetUpdateProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3EC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '감자의 하루',
                    style: AppTextStyle.m2Semi.copyWith(color: _ink),
                  ),
                ),
                Text(
                  '${today.month}월 ${today.day}일 ${['월', '화', '수', '목', '금', '토', '일'][today.weekday - 1]}요일',
                  style: AppTextStyle.labelRegular.copyWith(color: _muted),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              '오늘은 어떤 하루였나요?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'EF_Diary',
                fontSize: 24,
                height: 1.5,
                color: _ink,
              ),
            ),
            const SizedBox(height: 24),
            profile.when(
              data: (value) => _character(value, diary != null),
              loading: () => const SizedBox(
                height: 300,
                child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              error: (_, _) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  children: [
                    Text(
                      '감자를 불러오지 못했어요',
                      style: AppTextStyle.m3Regular.copyWith(color: _ink),
                    ),
                    TextButton(
                      onPressed: () => ref.invalidate(profileProvider),
                      child: const Text('다시 불러오기'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diary == null ? '오늘의 일기' : '오늘의 마음을 남겼어요',
                    style: AppTextStyle.labelSemi.copyWith(color: _muted),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    diary == null ? '기억하고 싶은 순간이 있었나요?' : diary.subject,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.m2Semi.copyWith(color: _ink),
                  ),
                  const SizedBox(height: 18),
                  DiaryButton(
                    text: diaries.hasError
                        ? '기록 다시 불러오기'
                        : diaries.isLoading
                        ? '기록 확인 중…'
                        : diary == null
                        ? '오늘의 일기 쓰기'
                        : '오늘의 일기 읽기',
                    backgroundColor: const Color(0xFF826A56),
                    isDisabled: diaries.isLoading,
                    onPressed: () {
                      if (diaries.hasError) {
                        ref.invalidate(diaryListProvider);
                        return;
                      }
                      PageRouter.router.push(
                        diary == null ? '/write' : '/read/${diary.id}',
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
