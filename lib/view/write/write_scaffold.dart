part of 'write_page.dart';

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    required this.header,
    required this.subjectInput,
    required this.editor,
    required this.toolbar,
    required this.submitButton,
    this.infoPanel,
    this.autoSaveStatus,
  });

  final Widget header;
  final Widget subjectInput;
  final Widget editor;
  final Widget toolbar;
  final Widget submitButton;
  final Widget? infoPanel;
  final Widget? autoSaveStatus;

  @override
  Widget build(BuildContext context) {
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // 헤더 + 임시저장 상태
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  header,
                  if (autoSaveStatus != null) ...[
                    const SizedBox(height: 4),
                    autoSaveStatus!,
                  ],
                ],
              ),
            ),
            // 스크롤 가능 영역 (제목 + 에디터)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    subjectInput,
                    const Divider(color: DiaryMainGrey.grey200, height: 24),
                    editor,
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // 본문 정보 패널 (토글)
            if (infoPanel != null) infoPanel!,
            // 툴바 (키보드 위에 고정)
            toolbar,
            // 완료 버튼 (키보드 없을 때만)
            if (!keyboardVisible)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.h),
                child: submitButton,
              ),
          ],
        ),
      ),
    );
  }
}
