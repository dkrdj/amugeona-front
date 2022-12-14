import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;

      return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                width / 8, height / 20, width / 8, height / 20),
            child: Column(
              children: <Widget>[
                Text(
                  '오늘은 뭘 먹을까?',
                  style: TextStyle(
                    fontSize: width / 30,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
