import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/view/components/input.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class TodoAddPage extends StatefulWidget {
  const TodoAddPage({super.key});

  @override
  State<TodoAddPage> createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  Duration settingTime = Duration.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              const TopNavigationBar(title: "도전과제 추가"),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("제목",
                      style: AppTextStyle.m3Regular
                          .copyWith(color: DiaryMainGrey.grey800)),
                  const SizedBox(
                    height: 12,
                  ),
                  const InputComponents(
                    hintText: "제목을 입력해주세요",
                    isLong: false,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Text("목표 시간",
                      style: AppTextStyle.m3Regular
                          .copyWith(color: DiaryMainGrey.grey800)),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                      width: double.infinity,
                      height: 50.h,
                      padding: EdgeInsets.only(left: 16.w),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: DiaryMainGrey.grey50,
                          borderRadius: BorderRadius.circular(8)),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                return SizedBox(
                                  height: 300.0,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CupertinoButton(
                                            child: const Text(
                                              '취소',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          CupertinoButton(
                                            child: const Text(
                                              '완료',
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                      CupertinoTimerPicker(
                                        mode: CupertinoTimerPickerMode.hm,
                                        onTimerDurationChanged: (value) {
                                          setState(() {
                                            settingTime = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: (settingTime) == Duration.zero
                            ? Text(
                                "시간을 설정해주세요",
                                style: AppTextStyle.m3Regular
                                    .copyWith(color: DiaryMainGrey.grey600),
                              )
                            : Text(
                                "${settingTime.inHours}시간 ${settingTime.inMinutes.remainder(60)}분",
                                style: AppTextStyle.m3Regular
                                    .copyWith(color: DiaryMainGrey.grey800),
                              ),
                      ))
                ],
              ),
            ],
          )),
    ));
  }
}
