import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Map<String, String>> postList;
  const PostListWidget({super.key, required this.postList});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: postList
          .map((post) =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  post['category'] ?? "없엉",
                  style: const TextStyle(color: Colors.blue),
                ),
                Text(
                  post['title'] ?? "없엉",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 14),
              ]))
          .toList(),
    ));
  }
}
