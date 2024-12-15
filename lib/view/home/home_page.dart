import 'package:flutter/material.dart';

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
    return const _Scaffold(
      header: _Header(),
      searchBox: _SearchBox(),
      diaryList: _DiaryList(),
    );
  }
}
