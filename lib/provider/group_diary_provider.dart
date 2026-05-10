import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:trade_diary/dataSource/group_diary.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/entry_comment.dart';
import 'package:trade_diary/model/entry_reaction.dart';
import 'package:trade_diary/model/group.dart';
import 'package:trade_diary/model/group_entry_share.dart';
import 'package:trade_diary/model/group_invite.dart';
import 'package:trade_diary/model/group_member.dart';
import 'package:trade_diary/model/group_round.dart';
import 'package:trade_diary/util/app_exception.dart';

final groupDiaryDataSourceProvider = Provider<GroupDiaryDataSource>((ref) {
  return GroupDiaryDataSource();
});

final groupsProvider = FutureProvider.autoDispose<List<GroupModel>>((ref) {
  return ref.read(groupDiaryDataSourceProvider).getGroups();
});

final groupInviteProvider =
    FutureProvider.autoDispose.family<GroupInviteModel?, String>((ref, groupId) {
  return ref.read(groupDiaryDataSourceProvider).getActiveInvite(groupId);
});

final todayRoundProvider =
    FutureProvider.autoDispose.family<GroupRoundModel, String>((ref, groupId) {
  return ref.read(groupDiaryDataSourceProvider).getOrCreateTodayRound(groupId);
});

final groupMembersProvider = FutureProvider.autoDispose
    .family<List<GroupMemberModel>, String>((ref, groupId) {
  return ref.read(groupDiaryDataSourceProvider).getMembers(groupId);
});

final roundSharesProvider = FutureProvider.autoDispose
    .family<List<GroupEntryShareModel>, String>((ref, roundId) {
  return ref.read(groupDiaryDataSourceProvider).getRoundShares(roundId);
});

final sharedEntriesProvider = FutureProvider.autoDispose
    .family<List<DiaryPostModel>, List<String>>((ref, entryIds) {
  return ref.read(groupDiaryDataSourceProvider).getSharedEntries(entryIds);
});

final shareCommentsProvider = FutureProvider.autoDispose
    .family<List<EntryCommentModel>, String>((ref, shareId) {
  return ref.read(groupDiaryDataSourceProvider).getComments(shareId);
});

final shareReactionsProvider = FutureProvider.autoDispose
    .family<List<EntryReactionModel>, String>((ref, shareId) {
  return ref.read(groupDiaryDataSourceProvider).getReactions(shareId);
});

class GroupDiaryActions {
  GroupDiaryActions(this.ref);

  final Ref ref;

  String get userId {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) throw AuthenticationException('로그인이 필요합니다');
    return user.id;
  }

  Future<GroupModel> createGroup(String name) async {
    final group = await ref.read(groupDiaryDataSourceProvider).createGroup(
          name: name,
        );
    ref.invalidate(groupsProvider);
    return group;
  }

  Future<void> joinGroup(String code) async {
    await ref.read(groupDiaryDataSourceProvider).joinByInviteCode(code);
    ref.invalidate(groupsProvider);
  }

  Future<void> shareEntry({
    required String entryId,
    required String groupId,
  }) async {
    final share = await ref.read(groupDiaryDataSourceProvider).shareEntry(
          entryId: entryId,
          groupId: groupId,
        );
    ref.invalidate(todayRoundProvider(groupId));
    ref.invalidate(roundSharesProvider(share.roundId));
  }

  Future<void> cancelShare(GroupEntryShareModel share) async {
    await ref.read(groupDiaryDataSourceProvider).cancelShare(share.id);
    ref.invalidate(roundSharesProvider(share.roundId));
  }

  Future<void> addComment({
    required String shareId,
    required String body,
  }) async {
    await ref.read(groupDiaryDataSourceProvider).addComment(
          shareId: shareId,
          userId: userId,
          body: body,
        );
    ref.invalidate(shareCommentsProvider(shareId));
  }

  Future<void> hideComment(EntryCommentModel comment) async {
    await ref.read(groupDiaryDataSourceProvider).hideComment(comment.id);
    ref.invalidate(shareCommentsProvider(comment.shareId));
  }

  Future<void> toggleHeart({
    required String shareId,
    required bool isReacted,
  }) async {
    final dataSource = ref.read(groupDiaryDataSourceProvider);
    if (isReacted) {
      await dataSource.removeReaction(shareId: shareId, userId: userId);
    } else {
      await dataSource.addReaction(shareId: shareId, userId: userId);
    }
    ref.invalidate(shareReactionsProvider(shareId));
  }
}

final groupDiaryActionsProvider = Provider<GroupDiaryActions>((ref) {
  return GroupDiaryActions(ref);
});
