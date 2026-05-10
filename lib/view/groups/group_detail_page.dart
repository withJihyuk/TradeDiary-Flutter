import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/group_entry_share.dart';
import 'package:trade_diary/model/group_round.dart';
import 'package:trade_diary/provider/group_diary_provider.dart';
import 'package:trade_diary/util/quill_content_util.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class GroupDetailPage extends ConsumerWidget {
  const GroupDetailPage({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roundState = ref.watch(todayRoundProvider(groupId));
    final inviteState = ref.watch(groupInviteProvider(groupId));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: roundState.when(
            data: (round) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopNavigationBar(title: '교환일기'),
                const SizedBox(height: 16),
                inviteState.when(
                  data: (invite) => Text(
                    invite == null ? '초대 코드 없음' : '초대 코드 ${invite.code}',
                    style: AppTextStyle.labelRegular
                        .copyWith(color: DiaryMainGrey.grey600),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 20),
                _RoundHeader(round: round),
                const SizedBox(height: 20),
                Expanded(child: _RoundBody(round: round)),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text(error.toString())),
          ),
        ),
      ),
    );
  }
}

class _RoundHeader extends StatelessWidget {
  const _RoundHeader({required this.round});

  final GroupRoundModel round;

  @override
  Widget build(BuildContext context) {
    final isPublished = round.status == GroupRoundStatus.published;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPublished ? const Color(0xFFEAF6EE) : const Color(0xFFFFF5E8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isPublished ? '오늘 교환일기가 공개됐어요' : '멤버들의 일기를 기다리는 중이에요',
            style: AppTextStyle.m2Semi,
          ),
          const SizedBox(height: 6),
          Text(
            '마감 ${round.deadlineAt.month}/${round.deadlineAt.day} ${round.deadlineAt.hour.toString().padLeft(2, '0')}:${round.deadlineAt.minute.toString().padLeft(2, '0')}',
            style: AppTextStyle.labelRegular.copyWith(
              color: DiaryMainGrey.grey700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundBody extends ConsumerWidget {
  const _RoundBody({required this.round});

  final GroupRoundModel round;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharesState = ref.watch(roundSharesProvider(round.id));
    final membersState = ref.watch(groupMembersProvider(round.groupId));

    return sharesState.when(
      data: (shares) {
        if (round.status == GroupRoundStatus.open) {
          return membersState.when(
            data: (members) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('제출 현황', style: AppTextStyle.m2Semi),
                const SizedBox(height: 12),
                Text(
                  '${shares.length}/${members.length}명 제출 완료',
                  style: AppTextStyle.m3Regular,
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Text(error.toString()),
          );
        }

        final entryIds = shares.map((share) => share.entryId).toList();
        final entriesState = ref.watch(sharedEntriesProvider(entryIds));
        return entriesState.when(
          data: (entries) => _PublishedShares(shares: shares, entries: entries),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(error.toString()),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text(error.toString()),
    );
  }
}

class _PublishedShares extends StatelessWidget {
  const _PublishedShares({required this.shares, required this.entries});

  final List<GroupEntryShareModel> shares;
  final List<DiaryPostModel> entries;

  @override
  Widget build(BuildContext context) {
    final entriesById = {for (final entry in entries) entry.id: entry};
    return ListView.separated(
      itemCount: shares.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final share = shares[index];
        final entry = entriesById[share.entryId];
        if (entry == null) return const SizedBox.shrink();
        return _SharedEntryCard(share: share, entry: entry);
      },
    );
  }
}

class _SharedEntryCard extends ConsumerStatefulWidget {
  const _SharedEntryCard({required this.share, required this.entry});

  final GroupEntryShareModel share;
  final DiaryPostModel entry;

  @override
  ConsumerState<_SharedEntryCard> createState() => _SharedEntryCardState();
}

class _SharedEntryCardState extends ConsumerState<_SharedEntryCard> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(shareCommentsProvider(widget.share.id));
    final reactions = ref.watch(shareReactionsProvider(widget.share.id));
    final userId = ref.read(groupDiaryActionsProvider).userId;
    final didReact = reactions.valueOrNull?.any((r) => r.userId == userId) ?? false;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DiaryMainGrey.grey50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.entry.subject.isEmpty ? '제목 없음' : widget.entry.subject,
              style: AppTextStyle.m2Semi),
          const SizedBox(height: 8),
          QuillEditor.basic(
            controller: QuillController(
              document: QuillContentUtil.contentToDocument(widget.entry.content),
              selection: const TextSelection.collapsed(offset: 0),
              readOnly: true,
            ),
            config: const QuillEditorConfig(showCursor: false),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => ref.read(groupDiaryActionsProvider).toggleHeart(
                      shareId: widget.share.id,
                      isReacted: didReact,
                    ),
                icon: Icon(didReact ? Icons.favorite : Icons.favorite_border),
                label: Text('${reactions.valueOrNull?.length ?? 0}'),
              ),
            ],
          ),
          comments.when(
            data: (items) => Column(
              children: [
                for (final comment in items)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(comment.body, style: AppTextStyle.m3Regular),
                    ),
                  ),
              ],
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const Text('댓글을 불러오지 못했어요'),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(hintText: '댓글 쓰기'),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final body = _commentController.text.trim();
                  if (body.isEmpty) return;
                  await ref.read(groupDiaryActionsProvider).addComment(
                        shareId: widget.share.id,
                        body: body,
                      );
                  _commentController.clear();
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
