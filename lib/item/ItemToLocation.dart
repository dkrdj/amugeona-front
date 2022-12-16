import 'package:amugeona/MainLayout.dart';
import 'package:amugeona/community/CommunityMain.dart';
import 'package:amugeona/recipe/RecipeMain.dart';
import 'package:amugeona/restaurant/RestaurantMain.dart';
import 'package:flutter/material.dart';

enum ItemToLocation {
  home(MainLayout()),
  restaurant(RestaurantMain()),
  recipe(RecipeMain()),
  community(CommunityMain());

  const ItemToLocation(this.widget);

  final Widget widget;
}
