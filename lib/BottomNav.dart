import 'package:flutter/material.dart';

import 'ChangePasswordLayout.dart';
import 'Signup.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNav createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  int _selectedIdx = 0; // 초반에 나올 화면
  final List _pages = [
    ChangePasswordLayout(),
    SignupLayout(),
    SignupLayout(),
    SignupLayout()
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black54,
      unselectedItemColor: Colors.black26,
      onTap: _onItemTapped,
      currentIndex: _selectedIdx,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: "맛집 찾기"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "레시피"),
        BottomNavigationBarItem(
            icon: Icon(Icons.people_outline), label: "커뮤니티"),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIdx = index;
    });
  }
}
