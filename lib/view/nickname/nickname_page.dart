import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/view/components/button.dart';
import 'package:trade_diary/view/components/input.dart';
import 'package:trade_diary/viewModel/profile_model.dart';

class NicknamePage extends StatelessWidget {
  const NicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    String value = "";
    ProfileViewModel viewModel = ProfileViewModel();
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  DiaryColor.backgroundColor,
                  DiaryColor.backgroundColor.withValues(alpha: 0.5)
                ])),
            child: Container(
                decoration: const BoxDecoration(
                  color: Color(0x60333333),
                ),
                child: ClipRect(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 256.h,
                          ),
                          Text(
                            '감자 이름을 정해주세요!',
                            style: AppTextStyle.h4Semi
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InputComponents(
                                hintText: "이름을 입력해 주세요",
                                isLong: false,
                                onChanged: (p0) {
                                  value = p0;
                                },
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              // Text(
                              //   "이미 존재하는 이름입니다.",
                              //   style: AppTextStyle.labelRegular
                              //       .copyWith(color: const Color(0xFFCB1111)),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 268.h,
                          ),
                          DiaryButton(
                              onPressed: () {
                                viewModel.setNickname(value);
                                context.go("/my");
                              },
                              text: "확인")
                        ],
                      )),
                )))));
  }
}
