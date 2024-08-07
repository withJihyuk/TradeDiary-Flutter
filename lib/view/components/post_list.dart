import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Map<String, String>> postList;
  const PostListWidget({super.key, required this.postList});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: Column(
          children: postList
              .map((post) => ListTile(
                    title: Text(post['title'] ?? "없엉"),
                    subtitle: Text(post['content'] ?? "없엉"),
                  ))
              .toList(),
        ));
  }
}
