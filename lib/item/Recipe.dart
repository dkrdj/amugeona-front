import 'package:amugeona/item/RecipeContent.dart';
import 'package:amugeona/item/RecipeIngredient.dart';

import 'RecipeImage.dart';

class Recipe {
  int? recipeSeq;
  String? title;
  String? thumbnail;
  double? starRating;
  int? starCnt;
  List? recipeIngredients;
  List? recipeContents;
  List? recipeImages;

  Recipe(
      {this.recipeSeq,
      this.title,
      this.thumbnail,
      this.starRating,
      this.starCnt,
      this.recipeIngredients,
      this.recipeContents,
      this.recipeImages});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var recipeIngredientList = (json['recipeIngredients'] ?? []) as List;
    var recipeContentList = (json['recipeContents'] ?? []) as List;
    var recipeImageList = (json['recipeImages'] ?? []) as List;
    return Recipe(
      recipeSeq: json['recipeSeq'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      starRating: json['starRating'] ?? 0,
      starCnt: json['starCnt'] ?? 0,
      recipeIngredients: recipeIngredientList
          .map((i) => RecipeIngredient.fromJson(i))
          .toList(),
      recipeContents:
          recipeContentList.map((i) => RecipeContent.fromJson(i)).toList(),
      recipeImages:
          recipeImageList.map((i) => RecipeImage.fromJson(i)).toList(),
    );
  }
}
