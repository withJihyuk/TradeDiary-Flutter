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
      if (ref.read(paginatedDiaryProvider).error != null) return;
      ref.read(paginatedDiaryProvider.notifier).loadMore();
    }
  }

  Future<void> _onRefresh() async {
    final messenger = ScaffoldMessenger.of(context);
    await ref.read(paginatedDiaryProvider.notifier).loadInitial();
    if (!mounted) return;
    if (ref.read(paginatedDiaryProvider).error != null) {
      messenger.showSnackBar(const SnackBar(content: Text('글을 새로 가져오지 못했어요')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              child: Column(
                children: [
                  widget.header,
                  const SizedBox(height: 18),
                  widget.searchBox,
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: DiaryColor.buttonSpecificColor,
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                      sliver: widget.diaryList,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
