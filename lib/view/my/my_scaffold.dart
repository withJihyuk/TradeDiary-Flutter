part of 'my_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.header,
    required this.totalValues,
    required this.settingOptions,
  });

  final Widget header;
  final Widget totalValues;
  final Widget settingOptions;

  double get headerMargin => 40.h;
  double get settingOptionsMargin => 60.h;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                child: Column(
                  children: [
                    header,
                    SizedBox(height: headerMargin),
                    totalValues,
                    SizedBox(height: settingOptionsMargin),
                    settingOptions,
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
