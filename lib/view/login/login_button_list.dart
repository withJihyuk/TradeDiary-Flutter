part of 'login_page.dart';

class _LoginButtonList extends StatelessWidget {
  // ignore: unused_element
  const _LoginButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    OauthViewModel oauthViewModel = OauthViewModel();
    return Column(
      children: [
        LoginButtonByPlatform(
            platform: "Google",
            iconPath: "assets/images/icons/google.svg",
            onPressed: () => oauthViewModel.nativeGoogleLogin()),
        const SizedBox(height: 14),
        LoginButtonByPlatform(
          platform: "Apple",
          iconPath: "assets/images/icons/google.svg",
          onPressed: () => oauthViewModel.nativeGoogleLogin(),
        ),
      ],
    );
  }
}

class LoginButtonByPlatform extends StatelessWidget {
  const LoginButtonByPlatform(
      {super.key,
      required this.platform,
      required this.iconPath,
      required this.onPressed});
  final String platform;
  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 84),
          decoration: BoxDecoration(
            border: Border.all(color: DiaryMainGrey.grey100),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 28,
                height: 28,
              ),
              Text("$platform로 시작하기", style: AppTextStyle.m2Semi)
            ],
          ),
        ));
  }
}
