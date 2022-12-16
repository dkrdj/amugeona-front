import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key, required this.currentTab, required this.onSelectTab});

  final String currentTab;
  final List tabList = ['home', 'restaurant', 'recipe', 'community'];
  final ValueChanged<String> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black54,
      unselectedItemColor: Colors.black26,
      items: [
        _buildItem('home'),
        _buildItem('restaurant'),
        _buildItem('recipe'),
        _buildItem('community'),
      ],
      onTap: (index) => onSelectTab(
        tabList[index],
      ),
      currentIndex: tabList.indexOf(currentTab),
    );
  }

  BottomNavigationBarItem _buildItem(String location) {
    IconData iconData;
    String name;
    switch (location) {
      case 'home':
        iconData = Icons.home;
        name = '홈';
        break;
      case 'restaurant':
        iconData = Icons.map_outlined;
        name = '맛집 찾기';
        break;
      case 'recipe':
        iconData = Icons.book;
        name = '레시피';
        break;
      case 'community':
        iconData = Icons.people_outline;
        name = '커뮤니티';
        break;
      default:
        iconData = Icons.home;
        name = '홈';
    }
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
      ),
      label: name,
    );
  }
}
