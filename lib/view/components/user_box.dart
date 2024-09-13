import 'package:flutter/material.dart';
import 'package:trade_diary/model/user_profile.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_diary/viewModel/user_profile.dart';

class UserBox extends StatelessWidget {
  final String id;
  UserBox({super.key, required this.id});

  final viewModel = UserProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.getUserProfile(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          context.go('error');
          return const Scaffold();
        } else if (snapshot.hasData) {
          var user = (snapshot.data as List)
              .map((user) => UserProfileModel.fromJson(user as Map<String, dynamic>))
              .toList();
          return Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  user[0].profileUrl,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user[0].nickname,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                  Text(user[0].description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                ],
              ),
            ],
          );
        } else {
          context.go('error');
          return const Scaffold();
        }
      },
    );
  }
}
