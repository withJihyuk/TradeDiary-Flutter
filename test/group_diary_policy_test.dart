import 'package:flutter_test/flutter_test.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/group_entry_share.dart';
import 'package:trade_diary/model/group_round.dart';
import 'package:trade_diary/util/group_diary_policy.dart';

void main() {
  group('GroupDiaryPolicy', () {
    test('allows many personal entries but only one active share per group round', () {
      final shares = [
        GroupEntryShareModel(
          id: 'share-1',
          groupId: 'group-1',
          roundId: 'round-1',
          entryId: 'entry-1',
          userId: 'user-1',
          sharedAt: DateTime(2026, 5, 10, 9),
        ),
        GroupEntryShareModel(
          id: 'share-2',
          groupId: 'group-2',
          roundId: 'round-2',
          entryId: 'entry-2',
          userId: 'user-1',
          sharedAt: DateTime(2026, 5, 10, 10),
        ),
      ];

      expect(
        GroupDiaryPolicy.hasActiveShareForRound(
          shares: shares,
          groupId: 'group-1',
          roundId: 'round-1',
          userId: 'user-1',
        ),
        isTrue,
      );
      expect(
        GroupDiaryPolicy.hasActiveShareForRound(
          shares: shares,
          groupId: 'group-1',
          roundId: 'round-1',
          userId: 'user-2',
        ),
        isFalse,
      );
    });

    test('locks entry editing after any group round publishes it', () {
      final unlocked = DiaryPostModel(
        id: 'entry-1',
        userId: 'user-1',
        subject: '오늘',
        content: '[]',
        emotion: '행복한감자',
      );
      final locked = unlocked.copyWith(lockedAt: DateTime(2026, 5, 10, 20));

      expect(GroupDiaryPolicy.canEditEntry(unlocked, 'user-1'), isTrue);
      expect(GroupDiaryPolicy.canEditEntry(locked, 'user-1'), isFalse);
      expect(GroupDiaryPolicy.canEditEntry(unlocked, 'user-2'), isFalse);
    });

    test('allows share replacement only before round is published', () {
      final openRound = GroupRoundModel(
        id: 'round-1',
        groupId: 'group-1',
        roundDate: DateTime(2026, 5, 10),
        deadlineAt: DateTime(2026, 5, 10, 23, 59),
        status: GroupRoundStatus.open,
      );
      final publishedRound = openRound.copyWith(
        status: GroupRoundStatus.published,
        publishedAt: DateTime(2026, 5, 10, 21),
      );

      expect(GroupDiaryPolicy.canChangeShare(openRound), isTrue);
      expect(GroupDiaryPolicy.canChangeShare(publishedRound), isFalse);
    });
  });
}
