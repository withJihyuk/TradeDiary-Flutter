import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/model/profile.dart';
import 'package:trade_diary/util/level.dart';
import 'package:trade_diary/viewModel/profile_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProfileViewModel viewModel = ProfileViewModel();
  final LevelSystem levelSystem = LevelSystem();

  late Future<ProfileModel> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = viewModel.getInfo();
  }

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
                    FutureBuilder(
                      future: _profileFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        } else if (snapshot.hasError) {
                          return const Text('오류가 발생했거나 연결에 문제가 있어요.');
                        } else if (snapshot.hasData) {
                          return Padding(
                              padding:
                                  EdgeInsets.fromLTRB(32.w, 220.h, 32.w, 38.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "LV.${levelSystem.getLevel(snapshot.data!.exp)}",
                                            style: AppTextStyle.m2Semi
                                                .copyWith(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          Text(
                                            snapshot.data!.nickname,
                                            style: AppTextStyle.m2Semi.copyWith(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.exp.toString(),
                                            style: AppTextStyle.labelRegular
                                                .copyWith(
                                                    color: DiaryColor
                                                        .globalMainColor),
                                          ),
                                          Text(
                                            '/${levelSystem.expToNextLevel(snapshot.data!.exp)}',
                                            style: AppTextStyle.labelRegular
                                                .copyWith(
                                                    color:
                                                        DiaryMainGrey.grey200),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 12.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: snapshot.data!.exp,
                                            child: Container(
                                                color:
                                                    DiaryColor.globalMainColor),
                                          ),
                                          Flexible(
                                            flex: levelSystem.expToNextLevel(
                                                snapshot.data!.exp),
                                            child: Container(
                                                color: DiaryMainGrey.grey300),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              ));
                        } else {
                          return const Text('No data');
                        }
                      },
                    )
                  ],
                ),
              ),
            ]))));
  }
}
