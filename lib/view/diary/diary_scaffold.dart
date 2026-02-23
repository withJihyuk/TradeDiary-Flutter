part of 'diary_page.dart';

class _Scaffold extends ConsumerStatefulWidget {
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
  ConsumerState<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends ConsumerState<_Scaffold> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(paginatedDiaryProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  child: Column(
                    children: [
                      widget.header,
                      const SizedBox(height: 18),
                      widget.searchBox,
                      const SizedBox(height: 20),
                      widget.diaryList
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: widget.floatingActionButton);
  }
}
