import 'package:flutter/material.dart';
import 'package:trade_diary/i18n/image_editor.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:trade_diary/view/components/global_appbar.dart';

class WritePage extends StatelessWidget {
  const WritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppbar(title: "일기 쓰기"),
      body: Center(
        child: ProImageEditor.network(
          "https://jjal.today/data/file/gallery/654777533_LXcuaI8Q_bc6f86a21271009c43de1783cb6780dc9e657a4d.jpeg",
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
