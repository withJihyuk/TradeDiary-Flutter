part of 'diary_page.dart';

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "일기",
        style: AppTextStyle.h4Semi,
      ),
    ]);
  }
}
