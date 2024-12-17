import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/view/components/input.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

part 'write_scaffold.dart';
part 'write_subject_input.dart';
part 'write_content_input.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  @override
  Widget build(BuildContext context) {
    return _Scaffold(
        header: TopNavigationBar(title: "일기"),
        subjectInput: const _WriteSubjectInput(),
        contentInput: const _WriteContentInput(),
        submitButton: const Text("TEST"));
  }
}
