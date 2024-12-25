import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/provider/diary.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/input.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

part 'write_scaffold.dart';
part 'write_subject_input.dart';
part 'write_content_input.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  @override
  Widget build(BuildContext context) {
    return _Scaffold(
        header: const TopNavigationBar(title: "일기"),
        subjectInput: const _WriteSubjectInput(),
        contentInput: const _WriteContentInput(),
        submitButton: Button(
            onPressed: () {
              PageRouter.router.push("/select");
            },
            text: "다음"));
  }
}
