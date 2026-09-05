part of 'login_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.logo, required this.loginButton});

  final Widget logo;
  final Widget loginButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 28,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    logo,
                    const SizedBox(height: 30),
                    loginButton,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
