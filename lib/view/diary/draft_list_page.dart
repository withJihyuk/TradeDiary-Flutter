import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/service/draft_store.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/util/emotion.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/util/diary_post_date_util.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class DraftListPage extends ConsumerWidget {
  const DraftListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(draftStoreProvider);
    final drafts = store.drafts;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: TopNavigationBar(title: '임시저장'),
            ),
            Expanded(
              child: RefreshIndicator(
                color: DiaryColor.buttonSpecificColor,
                onRefresh: store.refresh,
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (drafts.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '쓰다 만 이야기 ${drafts.length}개',
                                style: AppTextStyle.m2Semi.copyWith(
                                  color: DiaryMainGrey.grey900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '남겨둔 마음을 이어서 적어보세요.',
                                style: AppTextStyle.labelRegular.copyWith(
                                  color: DiaryMainGrey.grey800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (store.error != null || store.localError != null)
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(14, 10, 4, 10),
                            decoration: BoxDecoration(
                              color: DiaryMainGrey.grey50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.cloud_off_outlined,
                                  size: 20,
                                  color: DiaryMainGrey.grey700,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    store.localError != null
                                        ? '기기 저장 공간을 확인해 주세요.'
                                        : '연결되면 보관한 글을 다시 저장할게요.',
                                    style: AppTextStyle.labelRegular.copyWith(
                                      color: DiaryMainGrey.grey800,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: store.refresh,
                                  style: TextButton.styleFrom(
                                    foregroundColor: DiaryMainGrey.grey900,
                                  ),
                                  child: const Text('재시도'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (drafts.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 72),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (store.refreshing)
                                const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: DiaryColor.buttonSpecificColor,
                                  ),
                                )
                              else ...[
                                Image.asset(
                                  'assets/images/character/img-potato-hungry.png',
                                  width: 96,
                                  height: 96,
                                  excludeFromSemantics: true,
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  '아직 쓰다 만 이야기가 없어요',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.m2Semi.copyWith(
                                    color: DiaryMainGrey.grey900,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '작성 중인 일기는 자동으로 보관돼요.\n여기에서 언제든 이어 쓸 수 있어요.',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.labelRegular.copyWith(
                                    color: DiaryMainGrey.grey800,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                TextButton.icon(
                                  onPressed: () =>
                                      PageRouter.router.push('/write'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: DiaryMainGrey.grey900,
                                    backgroundColor: DiaryColor.globalMainColor
                                        .withValues(alpha: .15),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 18,
                                  ),
                                  label: const Text('새 일기 쓰기'),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                        sliver: SliverList.separated(
                          itemCount: drafts.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) =>
                              _DraftCard(draft: drafts[index], store: store),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DraftCard extends StatelessWidget {
  const _DraftCard({required this.draft, required this.store});
  final LocalDraft draft;
  final DraftStore store;

  String _editedAt() {
    final value = draft.diary.updatedAt ?? draft.diary.createdAt;
    if (value == null) return '';
    final date = seoulTime(value);
    final now = seoulTime(DateTime.now());
    final days = DateTime.utc(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime.utc(date.year, date.month, date.day)).inDays;
    final day = days == 0
        ? '오늘'
        : days == 1
        ? '어제'
        : '${date.year == now.year ? '' : '${date.year}. '}${date.month}월 ${date.day}일';
    return '$day ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '이 글을 삭제할까요?',
          style: AppTextStyle.m2Semi.copyWith(color: DiaryMainGrey.grey900),
        ),
        content: const Text('삭제한 임시저장 글은 되돌릴 수 없어요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(foregroundColor: DiaryMainGrey.grey800),
            child: const Text('계속 보관'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFB33D32),
            ),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await store.delete(draft.diary.id!);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('삭제하지 못했어요. 다시 시도해 주세요')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final diary = draft.diary;
    final preview = QuillContentUtil.contentToPlainText(diary.content)
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    final hasImage = diary.content.contains('"image"');
    return Material(
      color: DiaryMainGrey.grey50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: DiaryMainGrey.grey100),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => PageRouter.router.push('/write', extra: diary.id),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 10, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      diary.subject.trim().isEmpty ? '제목 없는 일기' : diary.subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.m3Semi.copyWith(
                        color: DiaryMainGrey.grey900,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    tooltip: '일기 메뉴',
                    position: PopupMenuPosition.under,
                    offset: const Offset(0, 4),
                    constraints: const BoxConstraints(minWidth: 180),
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 22,
                      color: DiaryMainGrey.grey700,
                    ),
                    color: Colors.white,
                    surfaceTintColor: Colors.transparent,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: DiaryMainGrey.grey100),
                    ),
                    onSelected: (action) {
                      if (action == 'delete') {
                        _delete(context);
                      } else {
                        PageRouter.router.push('/write', extra: diary.id);
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'write',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit_outlined,
                              size: 18,
                              color: DiaryMainGrey.grey900,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '이어서 쓰기',
                              style: AppTextStyle.labelRegular.copyWith(
                                color: DiaryMainGrey.grey900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete_outline_rounded,
                              size: 18,
                              color: Color(0xFFB33D32),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '삭제',
                              style: AppTextStyle.labelRegular.copyWith(
                                color: const Color(0xFFB33D32),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  preview.isEmpty
                      ? (hasImage ? '사진이 담긴 일기' : '아직 내용이 없어요')
                      : preview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.labelRegular.copyWith(
                    color: DiaryMainGrey.grey800,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Image.asset(
                    Emotion.emotionMap[diary.emotion] ??
                        Emotion.emotionMap.values.first,
                    width: 24,
                    height: 24,
                    excludeFromSemantics: true,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _editedAt(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.labelRegular.copyWith(
                        fontSize: 12,
                        color: DiaryMainGrey.grey700,
                      ),
                    ),
                  ),
                  if (draft.dirty)
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Tooltip(
                        message: '이 기기에 보관 중',
                        child: Icon(
                          Icons.phone_iphone_outlined,
                          size: 15,
                          color: DiaryMainGrey.grey700,
                        ),
                      ),
                    ),
                  Text(
                    '이어서 쓰기',
                    style: AppTextStyle.labelSemi.copyWith(
                      fontSize: 12,
                      color: DiaryMainGrey.grey900,
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: DiaryMainGrey.grey700,
                  ),
                ],
              ),
              if (draft.conflict)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '다른 기기의 글과 함께 보관한 사본이에요.',
                    style: AppTextStyle.labelRegular.copyWith(
                      fontSize: 12,
                      color: DiaryMainGrey.grey800,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
