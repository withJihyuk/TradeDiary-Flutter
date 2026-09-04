import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
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
        errorBuilder: (_, _, _) => _errorPlaceholder(),
      );
    } else {
      final path = imageUrl.startsWith('file://')
          ? imageUrl.substring(7)
          : imageUrl;
      imageWidget = Image.file(
        File(path),
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _errorPlaceholder(),
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

/// 구분선 EmbedBuilder
class DividerEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'divider';

  @override
  bool get expanded => false;

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(color: DiaryMainGrey.grey300, thickness: 1),
    );
  }
}
