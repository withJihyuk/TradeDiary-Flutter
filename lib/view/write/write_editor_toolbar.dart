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
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 추가
          _ToolbarButton(
            label: '추가 메뉴',
            icon: Icons.add,
            isActive: panel == ToolbarPanel.add,
            onTap: () {
              ref
                  .read(toolbarPanelProvider.notifier)
                  .state = panel == ToolbarPanel.add
                  ? ToolbarPanel.none
                  : ToolbarPanel.add;
            },
          ),
          // 텍스트
          _ToolbarButton(
            label: '글자 서식',
            icon: Icons.text_fields_outlined,
            isActive: panel == ToolbarPanel.text,
            onTap: () {
              ref
                  .read(toolbarPanelProvider.notifier)
                  .state = panel == ToolbarPanel.text
                  ? ToolbarPanel.none
                  : ToolbarPanel.text;
            },
          ),
          // 이미지
          _ToolbarButton(
            label: '사진 추가',
            icon: Icons.image_outlined,
            onTap: () => _pickAndInsertImages(context, ref),
          ),
          const _ToolbarDivider(),
          // Undo
          _ToolbarButton(
            label: '실행 취소',
            icon: Icons.undo,
            onTap: () => controller.undo(),
          ),
          // Redo
          _ToolbarButton(
            label: '다시 실행',
            icon: Icons.redo,
            onTap: () => controller.redo(),
          ),
          // 닫기
          _ToolbarButton(
            label: panel != ToolbarPanel.none ? '메뉴 닫기' : '키보드 닫기',
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
            onTap: () => _pickAndInsertImages(context, ref),
          ),
          _AddPanelItem(
            icon: Icons.horizontal_rule_outlined,
            label: '구분선',
            onTap: () {
              final controller = ref.read(quillControllerProvider);
              final index = controller.selection.baseOffset;
              final length = controller.selection.extentOffset - index;
              controller.replaceText(
                index,
                length,
                const BlockEmbed('divider', 'hr'),
                null,
              );
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
              style: AppTextStyle.labelRegular.copyWith(
                color: DiaryMainGrey.grey700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _pickAndInsertImages(BuildContext context, WidgetRef ref) async {
  final controller = ref.read(quillControllerProvider);
  final store = ref.read(draftStoreProvider);
  try {
    final files = await ImagePicker().pickMultiImage(imageQuality: 50);
    if (!context.mounted || files.isEmpty) return;
    final existing = controller.document
        .toDelta()
        .toList()
        .where(
          (op) => op.value is Map && (op.value as Map).containsKey('image'),
        )
        .length;
    if (existing + files.length > 10) {
      throw StateError('사진은 최대 10장까지 추가할 수 있어요');
    }
    for (final file in files) {
      final path = await store.importImage(file.path);
      if (!context.mounted) return;
      final selection = controller.selection;
      final index = selection.start.clamp(0, controller.document.length - 1);
      final end = selection.end.clamp(index, controller.document.length - 1);
      controller.replaceText(index, end - index, BlockEmbed.image(path), null);
      controller.replaceText(index + 1, 0, '\n', null);
      controller.updateSelection(
        TextSelection.collapsed(offset: index + 2),
        ChangeSource.local,
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e is StateError
                ? e.message.toString()
                : '사진을 추가하지 못했어요. 다시 시도해 주세요',
          ),
        ),
      );
    }
  }
}
