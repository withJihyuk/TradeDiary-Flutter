import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/view/components/setting_menu.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';
import 'package:trade_diary/viewModel/oauth_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SystemSettingPage extends StatelessWidget {
  const SystemSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    OauthViewModel oauthViewModel = OauthViewModel();
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  children: [
                    const TopNavigationBar(title: "시스템"),
                    SizedBox(height: 40.h),
                    TextSettingMenu(
                      menuName: "이용약관",
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://working-mailman-871.notion.site/1685f20bda6f80de9e6fd71653317e55'));
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextSettingMenu(
                      menuName: "개인정보 처리방침",
                      onPressed: () {
                        launchUrl(Uri.parse(
                            'https://working-mailman-871.notion.site/1685f20bda6f80a3bc1fe4d5437772a7'));
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    GestureDetector(
                        onTap: () => oauthViewModel.logout(),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/icons/logout.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text("로그아웃",
                                style: AppTextStyle.m3Regular
                                    .copyWith(color: const Color(0xffCB1111)))
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () => PageRouter.router.push("/deleteId"),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/icons/user-exit.svg",
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Text("회원탈퇴",
                                style: AppTextStyle.m3Regular
                                    .copyWith(color: const Color(0xffCB1111)))
                          ],
                        ))
                  ],
                ))));
  }
}
