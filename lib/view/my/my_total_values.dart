part of 'my_page.dart';

class _MyTotalValues extends StatelessWidget {
  const _MyTotalValues();

  @override
  Widget build(BuildContext context) {
    double paddingBetween = 39.w;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingBetween),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "0",
                  style: AppTextStyle.h3Semi,
                ),
                Text(
                  "지금까지 뽑은 잡초 수",
                  style: AppTextStyle.m3Regular,
                )
              ],
            ),
            Column(children: [
              Text(
                "0",
                style: AppTextStyle.h3Semi,
              ),
              Text(
                "비료를 준 횟수",
                style: AppTextStyle.m3Regular,
              )
            ]),
          ],
        ));
  }
}
