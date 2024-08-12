import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Map<String, String>> postList;
  const PostListWidget({super.key, required this.postList});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: postList
          .map((post) =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  post['title'] ?? "없엉",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(post['content'] ?? "없엉"),
                const SizedBox(height: 20),
              ]))
          .toList(),
    ));
  }
}
