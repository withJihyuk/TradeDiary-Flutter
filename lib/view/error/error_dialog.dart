import 'package:flutter/material.dart';

class ErrorDialog {
  static Future<dynamic> showProfileLoadErrorDialog(
    BuildContext context, {
    required String errorMessage,
    required VoidCallback onRetry,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('프로필을 불러올 수 없어요'),
        content: const Text('서버에 장애가 발생 했거나, 유저가 올바르지 않은거 같아요.'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: const Text('재시도')),
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소')),
        ],
      ),
    );
  }
}
