import 'package:flutter/material.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';

class DiaryHomeContentRead extends StatelessWidget {
  const DiaryHomeContentRead({
    super.key,
    required this.contentName,
    required this.contentDate,
    required this.contentPreview,
    required this.contentEmotion,
    required this.onTap,
    this.onLongPressStart,
    this.isDraft = false,
  });

  final String contentName;
  final String contentDate;
  final String contentPreview;
  final String contentEmotion;
  final VoidCallback onTap;
  final GestureLongPressStartCallback? onLongPressStart;
  final bool isDraft;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onLongPressStart: onLongPressStart,
        behavior: HitTestBehavior.opaque,
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
                      Flexible(
                          child: Text(contentName,
                              style: AppTextStyle.m3Semi,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)),
                      if (isDraft) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: DiaryColor.globalMainColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '임시저장',
                            style: TextStyle(
                              fontSize: 11,
                              color: DiaryColor.globalMainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
                      const SizedBox(width: 20),
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
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
