import 'package:flutter/material.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/service/draft_store.dart';
import 'package:trade_diary/viewModel/oauth_model.dart';

class DeleteIdPage extends ConsumerStatefulWidget {
  const DeleteIdPage({super.key});
  @override
  ConsumerState<DeleteIdPage> createState() => _DeleteIdPageState();
}

class _DeleteIdPageState extends ConsumerState<DeleteIdPage> {
  bool _deleting = false;
  Future<void> _delete() async {
    if (_deleting) return;
    setState(() => _deleting = true);
    final store = ref.read(draftStoreProvider);
    try {
      await store.suspend();
      await OauthViewModel().deleteAccount();
      try {
        await store.purge();
      } finally {
        await OauthViewModel().logout();
      }
    } catch (_) {
      store.resume();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('탈퇴 처리를 완료하지 못했어요. 다시 시도해 주세요')),
        );
      }
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !_deleting,
    child: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: AbsorbPointer(
                absorbing: _deleting,
                child: const TopNavigationBar(title: '회원 탈퇴'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                children: [
                  Image.asset(
                    'assets/images/character/img-potato-sad.png',
                    height: 112,
                    excludeFromSemantics: true,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '떠나기 전에 확인해 주세요',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.h4Semi.copyWith(
                      color: DiaryMainGrey.grey900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '탈퇴하면 함께 쌓은 기록이 사라져요.',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.labelRegular.copyWith(
                      color: DiaryMainGrey.grey800,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: DiaryMainGrey.grey50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '삭제되는 정보',
                          style: AppTextStyle.m3Semi.copyWith(
                            color: DiaryMainGrey.grey900,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '계정과 감자 프로필\n작성한 일기와 임시저장 글',
                          style: AppTextStyle.labelRegular.copyWith(
                            color: DiaryMainGrey.grey800,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '삭제된 정보는 복원할 수 없어요.',
                          style: AppTextStyle.labelSemi.copyWith(
                            color: const Color(0xFFB33D32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DiaryButton(
                    text: '계속 함께하기',
                    textColor: Colors.white,
                    backgroundColor: const Color(0xFF826A56),
                    isDisabled: _deleting,
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _deleting ? null : _delete,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFB33D32),
                      minimumSize: const Size(double.infinity, 48),
                      textStyle: AppTextStyle.labelSemi,
                    ),
                    child: Text(_deleting ? '탈퇴 처리 중…' : '모든 기록을 삭제하고 탈퇴'),
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
