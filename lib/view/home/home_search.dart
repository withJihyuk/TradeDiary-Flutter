part of '../home/home_page.dart';

class _SearchBox extends StatelessWidget {
  const _SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      trailing: const [
        Icon(
          Icons.search,
          color: DiaryMainGrey.grey500,
        )
      ],
      hintText: "제목이나 내용으로 일기를 검색해보세요",
      hintStyle: WidgetStateProperty.all(
        AppTextStyle.m3Regular.copyWith(color: DiaryMainGrey.grey500),
      ),
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(DiaryMainGrey.grey50),
      shape: WidgetStateProperty.all(
        ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
