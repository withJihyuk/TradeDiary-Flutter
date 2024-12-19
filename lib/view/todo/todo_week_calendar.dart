part of 'todo_page.dart';

class _TodoWeekCalendar extends StatelessWidget {
  // ignore: unused_element
  const _TodoWeekCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: CalendarFormat.week,
      focusedDay: DateTime.now(),
      locale: 'ko_KR',
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle:
              AppTextStyle.labelRegular.copyWith(color: DiaryMainGrey.grey400),
          weekendStyle:
              AppTextStyle.labelRegular.copyWith(color: DiaryMainGrey.grey400)),
      calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: DiaryColor.globalMainColor,
            shape: BoxShape.circle,
          ),
          defaultTextStyle:
              AppTextStyle.m2Regular.copyWith(color: DiaryMainGrey.grey900),
          todayTextStyle: AppTextStyle.m2Semi.copyWith(color: Colors.white),
          weekendTextStyle:
              AppTextStyle.m2Regular.copyWith(color: DiaryMainGrey.grey900),
          disabledTextStyle:
              AppTextStyle.m2Regular.copyWith(color: DiaryMainGrey.grey600)),
      firstDay: DateTime(2024, 12, 12),
      lastDay: DateTime(2024, 12, 19),
      daysOfWeekHeight: 30,
      headerVisible: false,
    );
  }
}
