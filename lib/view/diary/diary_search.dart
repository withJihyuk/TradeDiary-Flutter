part of 'diary_page.dart';

class _SearchBox extends ConsumerStatefulWidget {
  const _SearchBox();

  @override
  ConsumerState<_SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends ConsumerState<_SearchBox> {
  Timer? _debounce;
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_refresh);
    _controller.addListener(_refresh);
    _controller.text = ref.read(paginatedDiaryProvider).query;
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(paginatedDiaryProvider.notifier).setQuery(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: _onChanged,
      trailing: [
        if (_focusNode.hasFocus && _controller.text.isNotEmpty)
          IconButton(
            tooltip: "검색어 지우기",
            onPressed: () {
              _controller.clear();
              _debounce?.cancel();
              ref.read(paginatedDiaryProvider.notifier).setQuery('');
            },
            icon: const Icon(Icons.close),
          ),
        SvgPicture.asset(
          'assets/images/icons/search.svg',
          width: 24,
          height: 24,
        ),
      ],
      hintText: "제목이나 내용으로 일기를 검색해보세요",
      hintStyle: WidgetStateProperty.all(
        AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey500),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12),
      ),
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(DiaryMainGrey.grey50),
      shape: WidgetStateProperty.all(
        ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
