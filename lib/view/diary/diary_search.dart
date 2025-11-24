part of 'diary_page.dart';

class _SearchBox extends ConsumerWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchBar(
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).state = value;
      },
      trailing: [
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
      padding:
          WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12)),
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(DiaryMainGrey.grey50),
      shape: WidgetStateProperty.all(
        ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
