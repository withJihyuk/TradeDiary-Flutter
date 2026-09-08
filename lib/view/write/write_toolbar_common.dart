part of 'write_page.dart';

// ─── 공통 툴바 버튼 ───

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: isActive,
      child: IconButton(
        tooltip: label,
        style: IconButton.styleFrom(
          backgroundColor: isActive
              ? DiaryColor.globalMainColor.withValues(alpha: .22)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        constraints: const BoxConstraints(minWidth: 44, minHeight: 48),
        padding: const EdgeInsets.all(8),
        icon: Icon(
          icon,
          size: 22,
          color: isActive ? const Color(0xFF826A56) : DiaryMainGrey.grey800,
        ),
      ),
    );
  }
}

class _ToolbarDivider extends StatelessWidget {
  const _ToolbarDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(width: 1, height: 20, color: DiaryMainGrey.grey200),
    );
  }
}
