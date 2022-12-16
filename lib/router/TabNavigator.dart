import 'package:amugeona/MainLayout.dart';
import 'package:amugeona/community/CommunityMain.dart';
import 'package:amugeona/restaurant/RestaurantMain.dart';
import 'package:flutter/material.dart';

import '../recipe/RecipeMain.dart';

class TabNavigatorRoutes {
  static const String root = '/';
// static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.location});

  final GlobalKey<NavigatorState>? navigatorKey;
  final String location;

  void _push(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         routeBuilders[TabNavigatorRoutes.detail]!(context),
    //   ),
    // );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) => getLocation(location),
    };
  }

  Widget getLocation(String location) {
    switch (location) {
      case 'home':
        return MainLayout();
      case 'restaurant':
        return RestaurantMain();
      case 'recipe':
        return RecipeMain();
      case 'community':
        return CommunityMain();
    }
    return MainLayout();
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}
