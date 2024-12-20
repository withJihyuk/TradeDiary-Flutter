import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class DeleteIdPage extends StatelessWidget {
  const DeleteIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  children: [
                    const TopNavigationBar(title: "회원탈퇴"),
                    SizedBox(height: 185.h),
                    Image.asset(
                      "assets/images/character/img-potato-sad.png",
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "정말 가시려구요?",
                      style: AppTextStyle.h4Semi
                          .copyWith(color: DiaryColor.globalMainColor),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "계속하기 버튼을 누르면, 탈퇴됩니다.",
                      style: AppTextStyle.m3Regular
                          .copyWith(color: DiaryMainGrey.grey800),
                    ),
                    SizedBox(
                      height: 223.h,
                    ),
                    const Row(
                      children: [],
                    )
                  ],
                ))));
  }
}
