import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/util/diary_post_date_util.dart';
import 'package:trade_diary/util/emotion.dart';
import 'package:trade_diary/util/diary_image_embed_builder.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class DiaryView extends StatelessWidget {
  const DiaryView({super.key, required this.posts, required this.day});
  final List<DiaryPostModel> posts;

  final int day;

  @override
  Widget build(BuildContext context) {
    final diaryDate = diaryEffectiveDateTime(posts[day]);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TopNavigationBar(title: "일기 읽기"),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${diaryDate.month}월 ${diaryDate.day}일",
                    style: AppTextStyle.h3Semi.copyWith(
                      color: DiaryColor.globalMainColor,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          Emotion.emotionMap[posts[day].emotion]!,
                          width: 180.w,
                          height: 180.h,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(posts[day].subject, style: AppTextStyle.m1Semi),
                      QuillEditor.basic(
                        controller: QuillController(
                          document: QuillContentUtil.contentToDocument(
                            posts[day].content,
                          ),
                          selection: const TextSelection.collapsed(offset: 0),
                          readOnly: true,
                        ),
                        config: QuillEditorConfig(
                          showCursor: false,
                          embedBuilders: [
                            DiaryImageEmbedBuilder(),
                            DividerEmbedBuilder(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
