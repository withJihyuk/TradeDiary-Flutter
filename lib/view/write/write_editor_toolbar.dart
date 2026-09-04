part of 'write_page.dart';

// ─── 메인 툴바 + 서브패널 ───

class _EditorToolbar extends ConsumerWidget {
  const _EditorToolbar({required this.editorFocusNode});

  final FocusNode editorFocusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panel = ref.watch(toolbarPanelProvider);

    // TextFieldTapRegion: 툴바 탭이 에디터 포커스를 빼앗지 않음
    return TextFieldTapRegion(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 서브패널
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: panel == ToolbarPanel.add
                ? const _AddPanel()
                : panel == ToolbarPanel.text
                    ? const _TextPanel()
                    : const SizedBox.shrink(),
          ),
          // 메인 툴바
          _MainToolbar(editorFocusNode: editorFocusNode),
        ],
      ),
    );
  }
}

// ─── 메인 툴바 행 ───

class _MainToolbar extends ConsumerWidget {
  const _MainToolbar({required this.editorFocusNode});

  final FocusNode editorFocusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panel = ref.watch(toolbarPanelProvider);
    final controller = ref.watch(quillControllerProvider);

    return Container(
      decoration: const BoxDecoration(
        color: DiaryMainGrey.grey50,
        border: Border(
          top: BorderSide(color: DiaryMainGrey.grey200, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        children: [
          // 추가
          _ToolbarButton(
            icon: Icons.add,
            isActive: panel == ToolbarPanel.add,
            onTap: () {
              ref.read(toolbarPanelProvider.notifier).state =
                  panel == ToolbarPanel.add
                      ? ToolbarPanel.none
                      : ToolbarPanel.add;
            },
          ),
          // 텍스트
          _ToolbarButton(
            icon: Icons.text_fields_outlined,
            isActive: panel == ToolbarPanel.text,
            onTap: () {
              ref.read(toolbarPanelProvider.notifier).state =
                  panel == ToolbarPanel.text
                      ? ToolbarPanel.none
                      : ToolbarPanel.text;
            },
          ),
          // 이미지
          _ToolbarButton(
            icon: Icons.image_outlined,
            onTap: () => _pickAndInsertImage(ref),
          ),
          const _ToolbarDivider(),
          // Undo
          _ToolbarButton(
            icon: Icons.undo,
            onTap: () => controller.undo(),
          ),
          // Redo
          _ToolbarButton(
            icon: Icons.redo,
            onTap: () => controller.redo(),
          ),
          const Spacer(),
          // 닫기
          _ToolbarButton(
            icon: panel != ToolbarPanel.none
                ? Icons.close
                : Icons.keyboard_hide_outlined,
            onTap: () {
              if (panel != ToolbarPanel.none) {
                ref.read(toolbarPanelProvider.notifier).state =
                    ToolbarPanel.none;
              } else {
                editorFocusNode.unfocus();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndInsertImage(WidgetRef ref) async {
    final controller = ref.read(quillControllerProvider);
    final pickedFiles = await ImagePicker().pickMultiImage(imageQuality: 50);
    if (pickedFiles.isEmpty) return;

    for (final file in pickedFiles) {
      final index = controller.selection.baseOffset;
      final length = controller.selection.extentOffset - index;
      controller.replaceText(index, length, BlockEmbed.image(file.path), null);
      final newIndex = index + 1;
      controller.replaceText(newIndex, 0, '\n', null);
      controller.updateSelection(
        TextSelection.collapsed(offset: newIndex + 1),
        ChangeSource.local,
      );
    }
  }
}

// ─── 추가 패널 ───

class _AddPanel extends ConsumerWidget {
  const _AddPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: DiaryMainGrey.grey50,
        border: Border(
          top: BorderSide(color: DiaryMainGrey.grey200, width: 0.5),
        ),
      ),
      child: Wrap(
        spacing: 32,
        runSpacing: 20,
        children: [
          _AddPanelItem(
            icon: Icons.image_outlined,
            label: '이미지',
            onTap: () async {
              final controller = ref.read(quillControllerProvider);
              ref.read(toolbarPanelProvider.notifier).state = ToolbarPanel.none;
              final pickedFiles =
                  await ImagePicker().pickMultiImage(imageQuality: 50);
              if (pickedFiles.isEmpty) return;
              for (final file in pickedFiles) {
                final index = controller.selection.baseOffset;
                final length = controller.selection.extentOffset - index;
                controller.replaceText(
                    index, length, BlockEmbed.image(file.path), null);
                final newIndex = index + 1;
                controller.replaceText(newIndex, 0, '\n', null);
                controller.updateSelection(
                  TextSelection.collapsed(offset: newIndex + 1),
                  ChangeSource.local,
                );
              }
            },
          ),
          _AddPanelItem(
            icon: Icons.horizontal_rule_outlined,
            label: '구분선',
            onTap: () {
              final controller = ref.read(quillControllerProvider);
              final index = controller.selection.baseOffset;
              final length = controller.selection.extentOffset - index;
              controller.replaceText(
                  index, length, const BlockEmbed('divider', 'hr'), null);
              controller.replaceText(index + 1, 0, '\n', null);
              controller.updateSelection(
                TextSelection.collapsed(offset: index + 2),
                ChangeSource.local,
              );
              ref.read(toolbarPanelProvider.notifier).state = ToolbarPanel.none;
            },
          ),
          _AddPanelItem(
            icon: Icons.format_quote_outlined,
            label: '인용구',
            onTap: () {
              final controller = ref.read(quillControllerProvider);
              controller.formatSelection(Attribute.blockQuote);
              ref.read(toolbarPanelProvider.notifier).state = ToolbarPanel.none;
            },
          ),
          _AddPanelItem(
            icon: Icons.link_outlined,
            label: '링크',
            onTap: () {
              ref.read(toolbarPanelProvider.notifier).state = ToolbarPanel.none;
              _showLinkSheet(context, ref);
            },
          ),
        ],
      ),
    );
  }
}

class _AddPanelItem extends StatelessWidget {
  const _AddPanelItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: DiaryMainGrey.grey700),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyle.labelRegular
                  .copyWith(color: DiaryMainGrey.grey700, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
