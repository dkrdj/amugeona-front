import 'dart:convert';

import 'package:amugeona/item/Recipe.dart';
import 'package:http/http.dart' as http;

class RecipeProviders {
  Uri uri =
      Uri.parse("http://localhost:8080/recipe/list?orderBy=recipeSeq&page=0");

  Future<List<Recipe>> fetchRecipe(String orderBy, int page) async {
    Uri uri = Uri.parse(
        "http://localhost:8080/recipe/list?orderBy=$orderBy&page=$page");
    final response = await http.get(uri, headers: {
      "access-token":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
    });

    if (response.statusCode == 200) {
      var list = jsonDecode(response.body) as List;
      return list.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception("안넘어옴");
    }
  }
}
