part of 'login_page.dart';

class _LoginButtonList extends StatefulWidget {
  const _LoginButtonList();
  @override
  State<_LoginButtonList> createState() => _LoginButtonListState();
}

class _LoginButtonListState extends State<_LoginButtonList> {
  String? _activePlatform;
  Future<void> _login(bool apple) async {
    if (_activePlatform != null) return;
    setState(() => _activePlatform = apple ? 'Apple' : 'Google');
    try {
      if (apple) {
        await OauthViewModel().signInWithApple();
      } else {
        await OauthViewModel().nativeGoogleLogin();
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('로그인하지 못했어요. 다시 시도해 주세요')));
      }
    } finally {
      if (mounted) setState(() => _activePlatform = null);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      LoginButtonByPlatform(
        platform: 'Google',
        iconPath: 'assets/images/icons/google.svg',
        isSigningIn: _activePlatform == 'Google',
        onPressed: _activePlatform == null ? () => _login(false) : null,
      ),
      if (Platform.isIOS) ...[
        const SizedBox(height: 14),
        LoginButtonByPlatform(
          platform: 'Apple',
          iconPath: 'assets/images/icons/apple.svg',
          isSigningIn: _activePlatform == 'Apple',
          onPressed: _activePlatform == null ? () => _login(true) : null,
        ),
      ],
    ],
  );
}

class LoginButtonByPlatform extends StatelessWidget {
  const LoginButtonByPlatform({
    super.key,
    required this.platform,
    required this.iconPath,
    required this.onPressed,
    this.isSigningIn = false,
  });
  final String platform;
  final String iconPath;
  final VoidCallback? onPressed;
  final bool isSigningIn;

  @override
  Widget build(BuildContext context) {
    final apple = platform == 'Apple';
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        backgroundColor: apple ? Colors.black : Colors.white,
        disabledBackgroundColor: apple ? Colors.black : Colors.white,
        foregroundColor: apple ? Colors.white : const Color(0xFF1F1F1F),
        disabledForegroundColor: apple ? Colors.white70 : DiaryMainGrey.grey800,
        side: BorderSide(color: apple ? Colors.black : DiaryMainGrey.grey300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: AppTextStyle.m3Semi,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            colorFilter: apple
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : null,
            excludeFromSemantics: true,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              isSigningIn ? '$platform 로그인 중…' : '$platform로 계속하기',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
