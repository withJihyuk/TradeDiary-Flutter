part of 'write_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.header,
    required this.subjectInput,
    required this.contentInput,
    required this.submitButton,
  });

  final Widget header;
  final Widget subjectInput;
  final Widget contentInput;
  final Widget submitButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  header,
                  const SizedBox(height: 40),
                  subjectInput,
                  const SizedBox(height: 28),
                  contentInput,
                  const SizedBox(height: 37),
                  submitButton
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
