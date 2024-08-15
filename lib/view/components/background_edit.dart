import 'package:flutter/material.dart';
import 'package:trade_diary/i18n/image_editor.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class BackgroundEdit extends StatelessWidget {
  final String imageUrl;
  const BackgroundEdit({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppbar(title: "수정하기"),
      body: Center(
        child: ProImageEditor.network(
          imageUrl,
          configs: ProImageEditorConfigs(
            i18n: ImageEditorKorean.i18n,
            cropRotateEditorConfigs:
                const CropRotateEditorConfigs(enabled: false),
            filterEditorConfigs: const FilterEditorConfigs(enabled: false),
            stickerEditorConfigs: StickerEditorConfigs(
              enabled: true,
              buildStickers: (setLayer, scrollController) {
                return const SizedBox();
              },
            ),
          ),
          callbacks: const ProImageEditorCallbacks(),
        ),
      ),
    );
  }
}
