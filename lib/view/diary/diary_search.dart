part of 'diary_page.dart';

class _SearchBox extends StatelessWidget {
  const _SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
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
