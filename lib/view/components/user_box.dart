import 'package:flutter/material.dart';

class UserBox extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  const UserBox(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            width: 48,
            height: 48,
            imageUrl,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            Text(description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          ],
        ),
      ],
    );
  }
}
