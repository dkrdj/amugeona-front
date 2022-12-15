import 'package:amugeona/BottomNav.dart';
import 'package:flutter/material.dart';

import 'CommunityMain.dart';
import 'TopNav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amugeona',
      theme: ThemeData(
        fontFamily: 'SCDream',
      ),
      home: const Scaffold(
        appBar: TopNav(),
        body: CommunityMain(),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
