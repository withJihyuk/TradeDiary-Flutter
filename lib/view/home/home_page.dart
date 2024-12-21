import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/desginSystem/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    DiaryColor.backgroundColor,
                    DiaryColor.backgroundColor.withValues(alpha: 0.5)
                  ]),
            ),
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 38.h),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 66.h, left: 213.w),
                      child: Image.asset("assets/images/character/sun.png",
                          width: 132.w, height: 135.h)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset("assets/images/character/cloud.png",
                        width: 102.w, height: 71.h),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 165.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text("LV.1"),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  const Text("감자")
                                ],
                              ),
                              const Text('0/12')
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: 12.h,
                            decoration: BoxDecoration(
                                color: DiaryMainGrey.grey500,
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          const Text("일기와 도전과제를 설정하면 감자가 성장해요")
                        ],
                      ))
                ],
              ),
            ))));
  }
}
