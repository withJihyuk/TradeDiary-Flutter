import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/designSystem/color.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/model/group.dart';
import 'package:trade_diary/provider/group_diary_provider.dart';
import 'package:trade_diary/router.dart';

class GroupsPage extends ConsumerWidget {
  const GroupsPage({super.key});

  Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('그룹 만들기'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: '그룹 이름'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('만들기'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (name == null || name.isEmpty) return;
    await ref.read(groupDiaryActionsProvider).createGroup(name);
  }

  Future<void> _showJoinDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final code = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('초대 코드 입력'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(hintText: '예: A1B2C3D4'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('참여'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (code == null || code.isEmpty) return;
    await ref.read(groupDiaryActionsProvider).joinGroup(code);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('그룹', style: AppTextStyle.h4Semi),
                  Row(
                    children: [
                      IconButton(
                        tooltip: '초대 코드 입력',
                        onPressed: () => _showJoinDialog(context, ref),
                        icon: const Icon(Icons.login),
                      ),
                      IconButton(
                        tooltip: '그룹 만들기',
                        onPressed: () => _showCreateDialog(context, ref),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: groups.when(
                  data: (items) {
                    if (items.isEmpty) return const _EmptyGroups();
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) =>
                          const Divider(color: DiaryMainGrey.grey50),
                      itemBuilder: (context, index) {
                        return _GroupTile(group: items[index]);
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupTile extends ConsumerWidget {
  const _GroupTile({required this.group});

  final GroupModel group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final round = ref.watch(todayRoundProvider(group.id));

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(group.name, style: AppTextStyle.m2Semi),
      subtitle: round.when(
        data: (value) => Text(
          value.status.name == 'published' ? '오늘 교환일기 공개됨' : '오늘 라운드 진행 중',
          style: AppTextStyle.labelRegular.copyWith(
            color: DiaryMainGrey.grey600,
          ),
        ),
        loading: () => const Text('상태 확인 중'),
        error: (_, __) => const Text('상태를 불러오지 못했어요'),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => PageRouter.router.push('/groups/${group.id}'),
    );
  }
}

class _EmptyGroups extends StatelessWidget {
  const _EmptyGroups();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '아직 참여 중인 그룹이 없어요',
            style: AppTextStyle.h4Semi.copyWith(
              color: DiaryColor.globalMainColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '상단 버튼으로 그룹을 만들거나 초대 코드로 참여해 보세요.',
            style: AppTextStyle.m3Regular.copyWith(
              color: DiaryMainGrey.grey700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
