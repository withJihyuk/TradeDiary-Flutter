part of 'login_page.dart';

class _LoginButtonList extends StatelessWidget {
  const _LoginButtonList();

  @override
  Widget build(BuildContext context) {
    OauthViewModel oauthViewModel = OauthViewModel();
    return Column(
      children: [
        LoginButtonByPlatform(
          platform: "Google",
          iconPath: "assets/images/icons/google.svg",
          onPressed: () => oauthViewModel.nativeGoogleLogin(),
        ),
        SizedBox(height: 14.h),
        LoginButtonByPlatform(
          platform: "Apple",
          iconPath: "assets/images/icons/apple.svg",
          onPressed: () => oauthViewModel.signInWithApple(),
        ),
      ],
    );
  }
}

class LoginButtonByPlatform extends StatelessWidget {
  const LoginButtonByPlatform({
    super.key,
    required this.platform,
    required this.iconPath,
    required this.onPressed,
  });
  final String platform;
  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 80.w),
        decoration: BoxDecoration(
          border: Border.all(color: DiaryMainGrey.grey100),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(iconPath, width: 28, height: 28),
            const SizedBox(width: 12),
            Text("$platform로 계속하기", style: AppTextStyle.m2Semi),
          ],
        ),
      ),
    );
  }
}
