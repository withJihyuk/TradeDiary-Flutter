import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/group_entry_share.dart';
import 'package:trade_diary/model/group_round.dart';

class GroupDiaryPolicy {
  const GroupDiaryPolicy._();

  static bool canEditEntry(DiaryPostModel entry, String currentUserId) {
    return entry.userId == currentUserId &&
        entry.lockedAt == null &&
        entry.deletedAt == null;
  }

  static bool canChangeShare(GroupRoundModel round) {
    return round.status == GroupRoundStatus.open;
  }

  static bool hasActiveShareForRound({
    required List<GroupEntryShareModel> shares,
    required String groupId,
    required String roundId,
    required String userId,
  }) {
    return shares.any(
      (share) =>
          share.groupId == groupId &&
          share.roundId == roundId &&
          share.userId == userId &&
          share.canceledAt == null,
    );
  }
}
