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
                    Row(
                      children: [
                        SmallButton(
                            onPressed: () {},
                            text: "회원탈퇴",
                            color: DiaryMainGrey.grey500),
                        SizedBox(width: 10.w),
                        SmallButton(
                            onPressed: () {},
                            text: "돌아가기",
                            color: DiaryColor.globalMainColor),
                      ],
                    )
                  ],
                ))));
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.color});
  final VoidCallback onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 53.w),
          alignment: Alignment.center,
          child: Text(text,
              style: AppTextStyle.m2Semi.copyWith(color: Colors.white)),
        ));
  }
}
