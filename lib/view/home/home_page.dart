import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';

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
                child: Column(children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 38.h),
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.only(top: 66.h, left: 213.w),
                        child: Image.asset("assets/images/character/sun.png",
                            width: 132.w, height: 135.h)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/images/character/cloud.png",
                          width: 102.w, height: 71.h),
                    ),
                  ])),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 110.h,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration:
                            const BoxDecoration(color: Color(0xFF826A56)),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/character/img-potato-1lv.png",
                        fit: BoxFit.cover,
                        height: 166.h,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(32.w, 220.h, 32.w, 38.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "LV.1",
                                      style: AppTextStyle.m2Semi
                                          .copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      "감자",
                                      style: AppTextStyle.m2Semi.copyWith(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '0',
                                      style: AppTextStyle.labelRegular.copyWith(
                                          color: DiaryColor.globalMainColor),
                                    ),
                                    Text(
                                      '/12',
                                      style: AppTextStyle.labelRegular.copyWith(
                                          color: DiaryMainGrey.grey200),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              width: double.infinity,
                              height: 12.h,
                              decoration: BoxDecoration(
                                  color: DiaryMainGrey.grey300,
                                  borderRadius: BorderRadius.circular(16)),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              "일기와 도전과제를 설정하면 감자가 성장해요",
                              style: AppTextStyle.labelRegular
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ]))));
  }
}
