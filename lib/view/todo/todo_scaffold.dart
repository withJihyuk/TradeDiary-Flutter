part of 'todo_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.header,
    required this.weekCalendar,
    required this.timeLine,
    required this.floatingActionButton,
  });

  final Widget header;
  final Widget weekCalendar;
  final Widget timeLine;
  final Widget floatingActionButton;

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
                    SizedBox(height: 20.h),
                    weekCalendar,
                    SizedBox(height: 40.h),
                    timeLine,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
