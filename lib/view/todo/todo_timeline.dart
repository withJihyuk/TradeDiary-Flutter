part of 'todo_page.dart';

class _TodoTimeLine extends StatelessWidget {
  // ignore: unused_element
  const _TodoTimeLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text("6 AM"),
            Container(
              height: 76.h,
              color: DiaryMainGrey.grey100,
              width: 1,
            ),
            const Text("7 AM")
          ],
        ),
        const Column(
          children: [Text("양치하기"), Text("양치하기")],
        )
      ],
    );
  }
}
