import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/emotion.dart';
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
                  const SizedBox(height: 20),
                  TableCalendar(
                    calendarFormat: CalendarFormat.week,
                    focusedDay: DateTime.now(),
                    locale: 'ko_KR',
                    daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: AppTextStyle.labelRegular
                            .copyWith(color: DiaryMainGrey.grey400),
                        weekendStyle: AppTextStyle.labelRegular
                            .copyWith(color: DiaryMainGrey.grey400)),
                    calendarStyle: CalendarStyle(
                        todayDecoration: const BoxDecoration(
                          color: DiaryColor.globalMainColor,
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: AppTextStyle.m2Regular
                            .copyWith(color: DiaryMainGrey.grey900),
                        todayTextStyle:
                            AppTextStyle.m2Semi.copyWith(color: Colors.white),
                        weekendTextStyle: AppTextStyle.m2Regular
                            .copyWith(color: DiaryMainGrey.grey900),
                        disabledTextStyle: AppTextStyle.m2Regular
                            .copyWith(color: DiaryMainGrey.grey600)),
                    firstDay: findFirstDateOfTheWeek(DateTime.now()),
                    lastDay: findLastDateOfTheWeek(DateTime.now()),
                    daysOfWeekHeight: 30,
                    headerVisible: false,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            Emotion.emotionMap[posts[day].emotion]!,
                            width: 180.w,
                            height: 180.h,
                          ),
                        ),
                        Text(
                          posts[day].subject,
                          style: AppTextStyle.m1Semi,
                        ),
                        Text(
                          posts[day].content,
                          style: AppTextStyle.m3Regular,
                        )
                      ],
                    ),
                  )
                ]))));
  }
}

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday - 1));
}

DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime.add(Duration(days: 7 - dateTime.weekday));
}
