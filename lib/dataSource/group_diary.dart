import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/model/entry_comment.dart';
import 'package:trade_diary/model/entry_reaction.dart';
import 'package:trade_diary/model/group.dart';
import 'package:trade_diary/model/group_entry_share.dart';
import 'package:trade_diary/model/group_invite.dart';
import 'package:trade_diary/model/group_member.dart';
import 'package:trade_diary/model/group_round.dart';
import 'package:trade_diary/util/app_exception.dart';

class GroupDiaryDataSource {
  GroupDiaryDataSource({SupabaseClient? client})
      : supabase = client ?? Supabase.instance.client;

  final SupabaseClient supabase;

  Future<List<GroupModel>> getGroups() async {
    try {
      final response = await supabase
          .from('groups')
          .select()
          .isFilter('archived_at', null)
          .order('created_at', ascending: false);
      return response.map((item) => GroupModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException('그룹을 불러오지 못했어요', originalError: e);
    }
  }

  Future<GroupModel> createGroup({
    required String name,
    String deadlineTime = '23:59:00',
  }) async {
    try {
      final response = await supabase.rpc(
        'create_group',
        params: {
          'group_name': name,
          'group_deadline': deadlineTime,
        },
      );
      return GroupModel.fromJson(Map<String, dynamic>.from(response));
    } catch (e) {
      throw DatabaseException('그룹을 만들지 못했어요', originalError: e);
    }
  }

  Future<GroupMemberModel> joinByInviteCode(String code) async {
    try {
      final response = await supabase.rpc(
        'join_group_by_invite',
        params: {'invite_code': code},
      );
      return GroupMemberModel.fromJson(Map<String, dynamic>.from(response));
    } catch (e) {
      throw DatabaseException('초대 코드로 그룹에 참여하지 못했어요', originalError: e);
    }
  }

  Future<GroupInviteModel?> getActiveInvite(String groupId) async {
    try {
      final response = await supabase
          .from('group_invites')
          .select()
          .eq('group_id', groupId)
          .isFilter('revoked_at', null)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();
      if (response == null) return null;
      return GroupInviteModel.fromJson(response);
    } catch (e) {
      throw DatabaseException('초대 코드를 불러오지 못했어요', originalError: e);
    }
  }

  Future<GroupRoundModel> getOrCreateTodayRound(String groupId) async {
    try {
      final response = await supabase.rpc(
        'get_or_create_today_round',
        params: {'target_group_id': groupId},
      );
      return GroupRoundModel.fromJson(Map<String, dynamic>.from(response));
    } catch (e) {
      throw DatabaseException('오늘 교환일기를 불러오지 못했어요', originalError: e);
    }
  }

  Future<List<GroupMemberModel>> getMembers(String groupId) async {
    try {
      final response = await supabase
          .from('group_members')
          .select()
          .eq('group_id', groupId)
          .eq('status', 'active')
          .order('joined_at');
      return response.map((item) => GroupMemberModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException('그룹 멤버를 불러오지 못했어요', originalError: e);
    }
  }

  Future<List<GroupEntryShareModel>> getRoundShares(String roundId) async {
    try {
      final response = await supabase
          .from('group_entry_shares')
          .select()
          .eq('round_id', roundId)
          .isFilter('canceled_at', null)
          .order('shared_at');
      return response
          .map((item) => GroupEntryShareModel.fromJson(item))
          .toList();
    } catch (e) {
      throw DatabaseException('공유된 일기를 불러오지 못했어요', originalError: e);
    }
  }

  Future<List<DiaryPostModel>> getSharedEntries(List<String> entryIds) async {
    if (entryIds.isEmpty) return [];
    try {
      final response = await supabase
          .from('diary')
          .select()
          .inFilter('id', entryIds)
          .order('createdAt', ascending: false);
      return response.map((item) => DiaryPostModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException('공유 일기 본문을 불러오지 못했어요', originalError: e);
    }
  }

  Future<GroupEntryShareModel> shareEntry({
    required String entryId,
    required String groupId,
    DateTime? roundDate,
  }) async {
    try {
      final response = await supabase.rpc(
        'share_entry_to_group',
        params: {
          'target_entry_id': entryId,
          'target_group_id': groupId,
          'target_round_date': roundDate?.toIso8601String().split('T').first,
        },
      );
      return GroupEntryShareModel.fromJson(Map<String, dynamic>.from(response));
    } catch (e) {
      throw DatabaseException('그룹에 일기를 공유하지 못했어요', originalError: e);
    }
  }

  Future<void> cancelShare(String shareId) async {
    try {
      await supabase.rpc(
        'cancel_group_share',
        params: {'target_share_id': shareId},
      );
    } catch (e) {
      throw DatabaseException('공유를 취소하지 못했어요', originalError: e);
    }
  }

  Future<List<EntryCommentModel>> getComments(String shareId) async {
    try {
      final response = await supabase
          .from('entry_comments')
          .select()
          .eq('share_id', shareId)
          .isFilter('hidden_at', null)
          .order('created_at');
      return response.map((item) => EntryCommentModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException('댓글을 불러오지 못했어요', originalError: e);
    }
  }

  Future<void> addComment({
    required String shareId,
    required String userId,
    required String body,
  }) async {
    try {
      await supabase.from('entry_comments').insert({
        'share_id': shareId,
        'user_id': userId,
        'body': body,
      });
    } catch (e) {
      throw DatabaseException('댓글을 남기지 못했어요', originalError: e);
    }
  }

  Future<void> hideComment(String commentId) async {
    try {
      await supabase.from('entry_comments').update({
        'hidden_at': DateTime.now().toIso8601String(),
        'hidden_by': supabase.auth.currentUser?.id,
      }).eq('id', commentId);
    } catch (e) {
      throw DatabaseException('댓글을 삭제하지 못했어요', originalError: e);
    }
  }

  Future<List<EntryReactionModel>> getReactions(String shareId) async {
    try {
      final response = await supabase
          .from('entry_reactions')
          .select()
          .eq('share_id', shareId);
      return response.map((item) => EntryReactionModel.fromJson(item)).toList();
    } catch (e) {
      throw DatabaseException('공감을 불러오지 못했어요', originalError: e);
    }
  }

  Future<void> addReaction({
    required String shareId,
    required String userId,
    String reaction = 'heart',
  }) async {
    try {
      await supabase.from('entry_reactions').upsert({
        'share_id': shareId,
        'user_id': userId,
        'reaction': reaction,
      }, onConflict: 'share_id,user_id,reaction');
    } catch (e) {
      throw DatabaseException('공감을 남기지 못했어요', originalError: e);
    }
  }

  Future<void> removeReaction({
    required String shareId,
    required String userId,
    String reaction = 'heart',
  }) async {
    try {
      await supabase
          .from('entry_reactions')
          .delete()
          .eq('share_id', shareId)
          .eq('user_id', userId)
          .eq('reaction', reaction);
    } catch (e) {
      throw DatabaseException('공감을 취소하지 못했어요', originalError: e);
    }
  }

  Future<void> upsertPushToken(String token) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    try {
      await supabase.from('user_push_tokens').upsert({
        'user_id': userId,
        'token': token,
        'platform': Platform.isIOS ? 'ios' : 'android',
        'enabled': true,
        'updated_at': DateTime.now().toIso8601String(),
      }, onConflict: 'token');
    } catch (e) {
      throw DatabaseException('푸시 토큰을 저장하지 못했어요', originalError: e);
    }
  }
}
