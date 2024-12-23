import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class DiaryView extends StatelessWidget {
  const DiaryView({super.key, required this.posts, required this.day});
  final List<DiaryPostModel> posts;
  final int day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Column(children: [
                  const TopNavigationBar(title: "일기 읽기"),
                  Text(posts[day].toString()),
                ]))));
  }
}
