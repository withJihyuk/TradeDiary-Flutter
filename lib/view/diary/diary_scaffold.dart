part of 'diary_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.header,
    required this.searchBox,
    required this.diaryList,
    required this.floatingActionButton,
  });

  final Widget header;
  final Widget searchBox;
  final Widget diaryList;
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
                      const SizedBox(height: 18),
                      searchBox,
                      const SizedBox(height: 20),
                      diaryList
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatingActionButton);
  }
}
