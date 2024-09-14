import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/model/diary_post.dart';
import 'package:trade_diary/repository/diary_post.dart';
import 'package:trade_diary/view/components/global_appbar.dart';
import 'package:trade_diary/view/components/user_box.dart';
import 'package:trade_diary/view/error/not_found.dart';

class ReadPage extends ConsumerWidget {
  final String id;
  const ReadPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<DiaryPostModel>> data = ref.watch(getDiaryPost(id));
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppbar(
        title: "일기",
      ),
      body: data.when(
        data: (data) => Text(data.toString()),
        error: (error, stackTrace) => const NotFoundPage(),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
