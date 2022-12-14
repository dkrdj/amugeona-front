import 'package:amugeona/BottomNav.dart';
import 'package:amugeona/RecipeDetail.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: RecipeDetail(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: BottomNav(),
    ));
  }
}
