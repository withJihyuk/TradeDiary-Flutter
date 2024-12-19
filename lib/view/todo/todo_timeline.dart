part of 'todo_page.dart';

class _TodoTimeLine extends StatefulWidget {
  // ignore: unused_element
  const _TodoTimeLine({super.key});

  @override
  State<_TodoTimeLine> createState() => __TodoTimeLineState();
}

class __TodoTimeLineState extends State<_TodoTimeLine> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WhatToDo(ischecked: false, onPressed: () {}, subject: "멍청한고양이"),
            WhatToDo(ischecked: false, onPressed: () {}, subject: "멍청한고양이")
          ],
        )
      ],
    );
  }
}

class WhatToDo extends StatefulWidget {
  const WhatToDo(
      {super.key,
      required this.ischecked,
      required this.onPressed,
      required this.subject});
  final bool ischecked;
  final VoidCallback onPressed;
  final String subject;

  @override
  State<WhatToDo> createState() => _WhatToDoState();
}

class _WhatToDoState extends State<WhatToDo> {
  late bool isSwitchChecked;
  @override
  void initState() {
    super.initState();
    isSwitchChecked = widget.ischecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: DiaryColor.globalMainColor,
          value: isSwitchChecked,
          onChanged: (value) {
            setState(() {
              isSwitchChecked = !isSwitchChecked; // Update local state
            });
            widget.onPressed();
          },
        ),
        Text(
          widget.subject,
          style: AppTextStyle.m2Regular,
        )
      ],
    );
  }
}
