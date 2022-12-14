import 'package:amugeona/Signup.dart';
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
      home: MyWidget(),
      // const LoginLayout(),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TabPage(),
    ));
  }
}

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIdx = 0; // 초반에 나올 화면
  final List _pages = [ChangePasswordLayout(), SignupLayout()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIdx],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black12,
        onTap: _onItemTapped,
        currentIndex: _selectedIdx,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined), label: "맛집 찾기"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "레시피"),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: "커뮤니티"),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIdx = index;
    });
  }
}
