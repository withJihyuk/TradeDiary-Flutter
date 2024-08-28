import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';

enum AlertSnakbarStatus { error, info, success }

class AlertSnakbar extends SnackBar {
  AlertSnakbar({
    required AlertSnakbarStatus status,
    required String content,
    super.key,
  }) : super(
            content: Row(
              children: [
                Icon(setIconByState(status).keys.first,
                    color: setIconByState(status).values.first),
                Text(content),
              ],
            ),
            backgroundColor: const Color(0xFF475364),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ));
}

Map<IconData, Color> setIconByState(AlertSnakbarStatus type) {
  switch (type) {
    case AlertSnakbarStatus.error:
      return {Icons.error: Colors.red};
    case AlertSnakbarStatus.info:
      return {Icons.info: DiaryColorBlue.light};
    case AlertSnakbarStatus.success:
      return {Icons.check_circle: Colors.green};
  }
}
