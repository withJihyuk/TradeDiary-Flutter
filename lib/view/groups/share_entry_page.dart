import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trade_diary/designSystem/fontsize.dart';
import 'package:trade_diary/provider/group_diary_provider.dart';
import 'package:trade_diary/router.dart';
import 'package:trade_diary/view/components/top_navigation_bar.dart';

class ShareEntryPage extends ConsumerWidget {
  const ShareEntryPage({super.key, required this.entryId});

  final String entryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopNavigationBar(title: '그룹에 공유'),
              const SizedBox(height: 20),
              Text('공유할 그룹을 선택하세요', style: AppTextStyle.m2Semi),
              const SizedBox(height: 12),
              Expanded(
                child: groups.when(
                  data: (items) {
                    if (items.isEmpty) {
                      return const Center(child: Text('참여 중인 그룹이 없어요.'));
                    }
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final group = items[index];
                        return ListTile(
                          title: Text(group.name),
                          trailing: const Icon(Icons.upload),
                          onTap: () async {
                            await ref.read(groupDiaryActionsProvider).shareEntry(
                                  entryId: entryId,
                                  groupId: group.id,
                                );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${group.name}에 공유했어요')),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => PageRouter.router.go('/archive'),
                  child: const Text('개인 보관함에만 저장'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
