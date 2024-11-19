import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_editor_plus/markdown_editor_plus.dart';
import 'package:trade_diary/desginSystem/color.dart';
import 'package:trade_diary/view/components/global_appbar.dart';
import 'package:trade_diary/view/components/user_box.dart';
import 'package:trade_diary/view/error/not_found.dart';
import '../../viewModel/diary_model.dart';

class ReadPage extends ConsumerWidget {
  final String id;
  const ReadPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(diaryPostProvider(id));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppbar(
        title: "일기",
      ),
      body: data.when(
        data: (data) => ReadingComponent(userId: data.first.userId, content: data.first.content),
        error: (error, stackTrace) => const NotFoundPage(),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ReadingComponent extends StatelessWidget {
  final String userId;
  final String content;
  const ReadingComponent(
      {super.key, required this.userId, required this.content});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.text += content;

    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                UserBox(id: userId),
                const Text(
                  "팔로우",
                  style: TextStyle(
                      fontSize: 18,
                      color: DiaryColorBlue.normal,
                      fontWeight: FontWeight.w500),
                )
              ]),
              const SizedBox(
                height: 12,
              ),
              MarkdownField(
                padding: const EdgeInsets.all(0),
                controller: controller,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                maxLines: 40,
                readOnly: true,
              ),
            ])));
  }
}
