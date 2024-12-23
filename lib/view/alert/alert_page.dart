// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:trade_diary/desginSystem/color.dart';
// import 'package:trade_diary/desginSystem/fontsize.dart';
// import 'package:trade_diary/view/components/top_navigation_bar.dart';

// class AlertPage extends StatelessWidget {
//   const AlertPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20..w),
//           child: Column(
//             children: [
//               const TopNavigationBar(title: "알림"),
//               SizedBox(height: 24.h),
//               Container(
//                 height: 1,
//                 width: double.infinity,
//                 color: DiaryMainGrey.grey50,
//               ),
//               const AlertComponents()
//             ],
//           )),
//     ));
//   }
// }

// class AlertComponents extends StatelessWidget {
//   const AlertComponents({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 22.h),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "감자가 슬퍼하고 있어요",
//                   style: AppTextStyle.m2Semi,
//                 ),
//                 Text(
//                   "오늘 일기를 써주실래요?",
//                   style: AppTextStyle.labelRegular
//                       .copyWith(color: DiaryMainGrey.grey800),
//                 )
//               ],
//             ),
//             SizedBox(height: 4.w),
//             Text("12월 25일",
//                 style: AppTextStyle.labelRegular
//                     .copyWith(color: DiaryMainGrey.grey800)),
//           ],
//         ));
//   }
// }
