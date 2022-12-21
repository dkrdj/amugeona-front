import 'dart:convert';

import 'package:amugeona/item/Recipe.dart';
import 'package:http/http.dart' as http;

class RecipeProviders {
  Uri uri =
      Uri.parse("http://localhost:8080/recipe/list?orderBy=recipeSeq&page=0");

  Future<Recipe> getRecipe() async {
    // List<Recipe> recipe = [];

    final response = await http.get(uri, headers: {
      "access-token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
    });

    if (response.statusCode == 200) {
      return Recipe.fromJson(jsonDecode(response.body));
      // recipe = jsonDecode(response.body)['recipe'].map<Recipe>((recipe) {
      //   return Recipe.fromMap(recipe);
      // }).toList();
    } else {
      throw Exception("안넘어옴");
    }
    // return recipe;
  }
}
