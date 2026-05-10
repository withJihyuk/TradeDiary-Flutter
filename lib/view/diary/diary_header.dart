part of 'diary_page.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "보관함",
        style: AppTextStyle.h4Semi,
      ),
    ]);
  }
}
