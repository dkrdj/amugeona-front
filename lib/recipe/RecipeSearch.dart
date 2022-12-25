import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../appBar/TopNav.dart';
import '../item/Recipe.dart';

class RecipeSearch extends StatefulWidget {
  const RecipeSearch({super.key});

  @override
  State<RecipeSearch> createState() => _RecipeSearch();
}

Future<List<Recipe>> fetchSearchRecipe(
    String orderBy, String title, int page) async {
  var uri = Uri.http('54.180.86.129:8080', 'recipe/search-title',
      {'orderBy': orderBy, 'title': title, 'page': page.toString()});

  final response = await http.get(uri, headers: {
    "access-token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
  });

  if (response.statusCode == 200) {
    var list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Recipe> a = list.map((recipe) => Recipe.fromJson(recipe)).toList();
    return list.map((recipe) => Recipe.fromJson(recipe)).toList();
  } else {
    throw Exception("데이터를 받아오지 못함");
  }
}

class _RecipeSearch extends State<RecipeSearch> {
  String _selectedValue = '최근순';
  List<String> options = ['최근순', '조회순', '추천순', '댓글순'];
  List<Recipe> recipeAll = [];

  late Future<List<Recipe>> searchRecipe;

  @override
  void initState() {
    super.initState();
    searchRecipe = fetchSearchRecipe('recipeSeq', 'title', 0);
  }

  @override
  Widget build(BuildContext context) {
    String keyword = '레시피';
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      // for (int i = 0; i < 10; i++) {
      //   recipeAll.add(Recipe("레시피${i + 1}", 4.3 - 0.05 * i, 200 - 10 * i,
      //       'assets/images/logo.png'));
      // }
      return Scaffold(
        appBar: TopNav(
          keyword: keyword,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          children: [
            searchBar(width - width / 15 * 2, height),
            getOptionBar(width, height, options),
            FutureBuilder<List<Recipe>>(
                future: searchRecipe,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        ...snapshot.data!
                            .map((e) => getCard(width, height, e, 1))
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })
            // for (int i = 0; i < 10; i++)
            //   getCard(width, height, recipeAll[i], i),
          ],
        ),
      );
    });
  }

  Widget getCard(double width, double height, Recipe recipe, int idx) {
    return Container(
      width: width - width / 12 * 2,
      height: height / 9,
      padding: EdgeInsets.fromLTRB(width / 30, 0, width / 30, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: height / 100),
                  child: Text(
                    recipe.title!.length < 15
                        ? recipe.title!
                        : '${recipe.title!.substring(0, 15)}...',
                    style: TextStyle(
                      fontSize: width / 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: width / 50,
                      ),
                      child: Text(
                        recipe.starRating!.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: width / 40,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating:
                          double.parse(recipe.starRating!.toStringAsFixed(1)),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding:
                          EdgeInsets.symmetric(horizontal: width / 1000),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                      itemSize: width / 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 20),
                      child: Text(
                        '(${recipe.starCnt})',
                        style: TextStyle(
                          fontSize: width / 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  recipe.thumbnail!,
                  height: height / 18,
                ),
              ],
            ),
          ],
        ),
        Container(
          width: width - width / 12 * 2,
          height: 2,
          margin: EdgeInsets.only(top: height / 40),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: idx == 9 ? 0 : 1),
          ),
        )
      ]),
    );
  }

  Widget getOptionBar(double width, double height, List<String> options) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height / 50,
        top: height / 70,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButton<String>(
            value: _selectedValue,
            items: options.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            iconSize: width / 15,
            onChanged: (val) {
              setState(() {
                _selectedValue = val!;
              });
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: width / 28,
            ),
            focusColor: Colors.black45,
            underline: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget searchBar(double width, double height) {
    return Container(
      width: width,
      height: height / 19,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: width / 15),
            width: width * 0.86,
            child: TextFormField(
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 40, right: width / 40),
            child: Icon(
              Icons.search,
              size: width / 13 > height / 25 ? width / 13 : height / 25,
            ),
          ),
        ],
      ),
    );
  }
}