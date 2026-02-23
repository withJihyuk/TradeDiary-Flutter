import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trade_diary/designSystem/color.dart';

/// QuillEditor 내 인라인 이미지를 렌더링하는 EmbedBuilder.
/// 로컬 파일 경로(편집 중)와 CDN URL(저장 후 읽기) 모두 지원.
class DiaryImageEmbedBuilder extends EmbedBuilder {
  @override
  String get key => BlockEmbed.imageType;

  @override
  bool get expanded => false;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    final imageUrl = embedContext.node.value.data as String;

    final Widget imageWidget;
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      imageWidget = Image.network(
        imageUrl,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _errorPlaceholder(),
      );
    } else {
      final path =
          imageUrl.startsWith('file://') ? imageUrl.substring(7) : imageUrl;
      imageWidget = Image.file(
        File(path),
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _errorPlaceholder(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageWidget,
      ),
    );
  }

  static Widget _errorPlaceholder() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: DiaryMainGrey.grey100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.broken_image, color: DiaryMainGrey.grey500),
      ),
    );
  }
}

/// 툴바에 표시되는 인라인 이미지 삽입 버튼.
/// QuillToolbarIconButton을 사용하여 다른 툴바 버튼과 스타일 통일.
Widget imageEmbedButton(
  BuildContext context,
  EmbedButtonContext embedContext,
) {
  return QuillToolbarIconButton(
    icon: Icon(Icons.image_outlined, size: 26.w, color: Colors.black),
    isSelected: false,
    iconTheme: embedContext.iconTheme,
    onPressed: () async {
      final pickedFiles = await ImagePicker().pickMultiImage(imageQuality: 50);
      if (pickedFiles.isEmpty) return;

      final controller = embedContext.controller;
      for (final file in pickedFiles) {
        final index = controller.selection.baseOffset;
        final length = controller.selection.extentOffset - index;
        controller.replaceText(
            index, length, BlockEmbed.image(file.path), null);
        // 이미지 삽입 후 커서를 이미지 아래로 이동
        final newIndex = index + 1;
        controller.replaceText(newIndex, 0, '\n', null);
        controller.updateSelection(
          TextSelection.collapsed(offset: newIndex + 1),
          ChangeSource.local,
        );
      }
    },
  );
}
