import 'package:flutter/material.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/provider/profile_provider.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/viewModel/profile_model.dart';

class NicknamePage extends ConsumerStatefulWidget {
  const NicknamePage({super.key});
  @override
  ConsumerState<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends ConsumerState<NicknamePage> {
  final _controller = TextEditingController();
  bool _loading = true;
  String? _originalName;
  bool _saving = false;
  String? _error;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final profile =
          ref.read(profileProvider).value ?? await ProfileViewModel().getInfo();
      if (!mounted) return;
      setState(() {
        _controller.text = profile.nickname;
        _originalName = profile.nickname;
        _loading = false;
        _error = null;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = '이름을 불러오지 못했어요';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || _loading) return;
    final value = _controller.text.trim();
    if (value.isEmpty || value.length > 30) {
      setState(() => _error = '이름은 1자 이상 30자 이내로 입력해 주세요');
      return;
    }
    setState(() => _saving = true);
    try {
      await ProfileViewModel().setNickname(value);
      if (!mounted) return;
      ref.invalidate(profileProvider);
      PageRouter.router.go('/my');
    } catch (_) {
      if (mounted) setState(() => _error = '이름을 저장하지 못했어요. 다시 시도해 주세요');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !_saving,
    child: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: AbsorbPointer(
                absorbing: _saving,
                child: const TopNavigationBar(title: '감자 이름'),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                children: [
                  Text(
                    '감자를 어떻게 부를까요?',
                    style: AppTextStyle.h4Semi.copyWith(
                      color: DiaryMainGrey.grey900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '함께 자라날 감자에게 이름을 지어주세요.',
                    style: AppTextStyle.labelRegular.copyWith(
                      color: DiaryMainGrey.grey800,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    '감자 이름',
                    style: AppTextStyle.labelSemi.copyWith(
                      color: DiaryMainGrey.grey900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_loading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: LinearProgressIndicator(),
                    ),
                  TextField(
                    controller: _controller,
                    enabled: !_loading && !_saving && _originalName != null,
                    maxLength: 30,
                    textInputAction: TextInputAction.done,
                    style: AppTextStyle.m3Regular.copyWith(
                      color: DiaryMainGrey.grey900,
                    ),
                    decoration: InputDecoration(
                      hintText: '감자 이름을 입력해 주세요',
                      hintStyle: AppTextStyle.labelRegular.copyWith(
                        color: DiaryMainGrey.grey700,
                      ),
                      filled: true,
                      fillColor: DiaryMainGrey.grey50,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: DiaryMainGrey.grey200,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: DiaryMainGrey.grey200,
                        ),
                      ),
                      errorText: _error,
                      errorMaxLines: 2,
                    ),
                    onChanged: (_) => setState(() => _error = null),
                    onSubmitted: (_) => _save(),
                  ),
                  if (_originalName == null && !_loading)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _load,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('이름 다시 불러오기'),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
              child: DiaryButton(
                text: _saving ? '저장 중…' : '이름 저장',
                textColor: Colors.white,
                backgroundColor: const Color(0xFF826A56),
                isDisabled:
                    _loading ||
                    _saving ||
                    _originalName == null ||
                    _controller.text.trim().isEmpty ||
                    _controller.text.trim() == _originalName,
                onPressed: _save,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
