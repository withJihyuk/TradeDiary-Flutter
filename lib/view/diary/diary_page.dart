import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/provider/diary_list.dart';
import 'package:trade_diary/router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/view/components/diary_home_content_read.dart';
import 'package:trade_diary/viewModel/diary_model.dart';

part 'diary_scaffold.dart';
part 'diary_header.dart';
part 'diary_search.dart';
part 'diary_list.dart';
part 'diary_floating_button.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  DiaryViewModel viewModel = DiaryViewModel();
  @override
  Widget build(BuildContext context) {
    return const _Scaffold(
      header: _Header(),
      searchBox: _SearchBox(),
      diaryList: _DiaryList(),
      floatingActionButton: _DiaryFloatingButton(),
    );
  }
}
