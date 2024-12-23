import 'package:flutter/material.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/desginSystem/fontsize.dart';

class DiaryHomeContentRead extends StatelessWidget {
  const DiaryHomeContentRead({
    super.key,
    required this.contentName,
    required this.contentDate,
    required this.contentPreview,
    required this.contentImage,
    required this.onTap,
  });

  final String contentName;
  final String contentDate;
  final String contentPreview;
  final String contentImage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        contentName,
                        style: AppTextStyle.m3Semi,
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 2,
                        height: 2,
                        decoration: const ShapeDecoration(
                          color: DiaryMainGrey.grey500,
                          shape: OvalBorder(),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        contentDate,
                        style: AppTextStyle.labelRegular.copyWith(
                          color: DiaryMainGrey.grey500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      contentPreview,
                      style: AppTextStyle.m3Regular.copyWith(
                        color: DiaryMainGrey.grey900,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.black,
            ),
          ],
        ));
  }
}
