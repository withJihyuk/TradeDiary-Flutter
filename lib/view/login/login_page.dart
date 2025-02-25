import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/viewModel/oauth_model.dart';

part 'login_scaffold.dart';
part 'login_button_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return _Scaffold(
        logo: Image.asset(
          "assets/images/icons/logo.png",
          width: 300.w,
          height: 300.h,
        ),
        loginButton: const _LoginButtonList());
  }
}
