import 'package:flutter/material.dart';

import 'ChangePasswordLayout.dart';

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
      home: const ChangePasswordLayout(),
    );
  }
}
