import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/router.dart';

part 'todo_scaffold.dart';
part 'todo_floating_button.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return const _Scaffold(
      header: Text("data"),
      weekCalendar: Text("data"),
      timeLine: Text("data"),
      floatingActionButton: _TodoFloatingButton(),
    );
  }
}
