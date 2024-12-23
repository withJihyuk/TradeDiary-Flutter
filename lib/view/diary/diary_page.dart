import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/view/components/diary_home_content_read.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  @override
  Widget build(BuildContext context) {
    return _Scaffold(
      header: const _Header(),
      searchBox: const _SearchBox(),
      diaryList: _DiaryList(
        diaryList: [
          DiaryPostModel(
              content: "as",
              subject: "asdf",
              emotion: "A",
              date: DateTime(2024, 12, 25),
              image: ["adsf"],
              isPrivate: false),
          DiaryPostModel(
              content: "감자튀김이 좋아요감자튀김이 좋아요감자튀김이 좋아요감자튀김이 좋아요감자튀김이 좋아요",
              subject: "감자튀김이 좋아요",
              emotion: "A",
              date: DateTime(2024, 12, 23),
              image: ["adsf"],
              isPrivate: false)
        ],
      ),
      floatingActionButton: const _DiaryFloatingButton(),
    );
  }
}
