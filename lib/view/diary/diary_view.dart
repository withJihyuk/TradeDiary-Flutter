import 'package:trade_diary/dataSource/diary_post.dart';
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

class DiaryView extends StatefulWidget {
  const DiaryView({super.key, required this.id, this.initial});
  final String id;
  final DiaryPostModel? initial;
  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  DiaryPostModel? _diary;
  QuillController? _controller;
  bool _loading = true;
  String? _error;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      if (!RegExp(r'^[0-9a-fA-F-]{36}$').hasMatch(widget.id)) {
        throw StateError('invalid id');
      }
      final diary =
          widget.initial ?? await DiaryPostDataSource().getById(widget.id);
      if (!mounted) return;
      if (diary == null || diary.isDraft) throw StateError('not found');
      _diary = diary;
      _controller?.dispose();
      _controller = QuillController(
        document: QuillContentUtil.contentToDocument(diary.content),
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      );
    } catch (_) {
      _error = '일기를 찾을 수 없거나 불러오지 못했어요';
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('일기 읽기')),
        body: Center(
          child: _loading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_error!),
                    TextButton(onPressed: _load, child: const Text('다시 시도')),
                  ],
                ),
        ),
      );
    }
    final diary = _diary!;
    final diaryDate = diaryEffectiveDateTime(diary);
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
                          Emotion.emotionMap[diary.emotion] ??
                              Emotion.emotionMap.values.first,
                          width: 180.w,
                          height: 180.h,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(diary.subject, style: AppTextStyle.m1Semi),
                      QuillEditor.basic(
                        controller: _controller!,
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
