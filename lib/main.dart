import 'package:amugeona/BottomNav.dart';
import 'package:amugeona/RecipeSearch.dart';
import 'package:amugeona/TopNav.dart';
import 'package:flutter/material.dart';

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
        body: RecipeSearch(),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
