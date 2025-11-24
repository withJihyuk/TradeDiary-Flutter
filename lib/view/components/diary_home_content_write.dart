import 'package:flutter/material.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';

class DiaryHomeContentWrite extends StatelessWidget {
  const DiaryHomeContentWrite({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: DiaryMainGrey.grey100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.edit_outlined,
              color: DiaryMainGrey.grey600,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              '오늘의 거래일지를 작성해보세요',
              style: AppTextStyle.m3Regular.copyWith(
                color: DiaryMainGrey.grey600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
