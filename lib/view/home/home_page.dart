import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/view/components/diary_home_content_read.dart';
import 'package:flutter_svg/flutter_svg.dart';

part '../home/home_scaffold.dart';
part '../home/home_header.dart';
part '../home/home_search.dart';
part '../home/home_diary.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              date: DateTime(2024, 12, 10),
              image: "adsf",
              isPrivate: false),
          DiaryPostModel(
              content: "감자튀김이 좋아요감자튀김이 좋아요감자튀김이 좋아요감자튀김이 좋아요감자튀김이 좋아요",
              subject: "감자튀김이 좋아요",
              date: DateTime(2024, 12, 25),
              image: "adsf",
              isPrivate: false)
        ],
      ),
    );
  }
}
