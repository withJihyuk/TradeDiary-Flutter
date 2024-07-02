import 'package:flutter/material.dart';
import 'package:trade_diary/router.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '교환일기',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'PretendardJP',
      ),
      routeInformationParser: PageRouter.router.routeInformationParser,
      routeInformationProvider: PageRouter.router.routeInformationProvider,
      routerDelegate: PageRouter.router.routerDelegate,
      
    );
  }
}
