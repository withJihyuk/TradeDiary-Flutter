import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/router.dart';

part 'todo_scaffold.dart';
part 'todo_header.dart';
part 'todo_week_calendar.dart';
part 'todo_floating_button.dart';
part 'todo_timeline.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return const _Scaffold(
      header: _TodoHeader(),
      weekCalendar: _TodoWeekCalendar(),
      timeLine: _TodoTimeLine(),
      floatingActionButton: _TodoFloatingButton(),
    );
  }
}
