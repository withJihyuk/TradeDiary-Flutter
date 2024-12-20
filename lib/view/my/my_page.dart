import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/view/components/setting_menu.dart';

part 'my_scaffold.dart';
part 'my_header.dart';
part 'my_total_values.dart';
part 'my_setting_options.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return const _Scaffold(
      header: _MyHeader(),
      totalValues: _MyTotalValues(),
      settingOptions: _MySettingOptions(),
    );
  }
}
