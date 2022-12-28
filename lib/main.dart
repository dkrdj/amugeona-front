import 'package:amugeona/router/TabNavigator.dart';
import 'package:flutter/material.dart';

import 'appBar/BottomNav.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const _MyApp(),
      // home: CommunityList(),
    );
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  String _currentTab = 'home';
  final _navigatorKeys = {
    'home': GlobalKey<NavigatorState>(),
    'restaurant': GlobalKey<NavigatorState>(),
    'recipe': GlobalKey<NavigatorState>(),
    'community': GlobalKey<NavigatorState>(),
  };

  void _selectTab(String location) {
    if (location == _currentTab) {
      // pop to first route
      _navigatorKeys[location]!
          .currentState!
          .popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != 'home') {
            // select 'main' tab
            _selectTab('home');
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator('home'),
          _buildOffstageNavigator('restaurant'),
          _buildOffstageNavigator('recipe'),
          _buildOffstageNavigator('community'),
        ]),
        bottomNavigationBar: BottomNav(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String location) {
    return Offstage(
      offstage: _currentTab != location,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[location],
        location: location,
      ),
    );
  }
}
