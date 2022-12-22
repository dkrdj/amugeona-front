import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import '../appBar/TopNav.dart';
import '../item/Recipe.dart';

class RecipeMain extends StatefulWidget {
  const RecipeMain({super.key});

  @override
  State<RecipeMain> createState() => _RecipeMain();
}

Future<List<Recipe>> fetchRecipe(String orderBy, int page) async {
  var uri = Uri.http('54.180.86.129:8080', 'recipe/list',
      {'orderBy': orderBy, 'page': page.toString()});

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

class _RecipeMain extends State<RecipeMain> {
  late Future<List<Recipe>> recipeList;
  late Future<List<Recipe>> popularList;
  String _selectedValue = '최근순';
  List<String> options = ['최근순', '조회순', '추천순', '댓글순'];

  @override
  void initState() {
    super.initState();
    recipeList = fetchRecipe('recipeSeq', 0);
    popularList = fetchRecipe('starRating', 0);
  }

  @override
  Widget build(BuildContext context) {
    String keyword = '레시피';

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(
        appBar: TopNav(
          keyword: keyword,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          child: ListView(
            children: [
              searchBar(width - width / 15 * 2, height),
              FutureBuilder<List<Recipe>>(
                  future: popularList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return getTopList(width, height, snapshot.data!, '인기레시피');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              getOptionBar(width, height, options),
              FutureBuilder<List<Recipe>>(
                future: recipeList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        ...snapshot.data!.map(
                          (e) => getCard(width, height, e, 1),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget getCard(double width, double height, Recipe recipe, int idx) {
    return Container(
      width: width - width / 15 * 2,
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
                Image.network(
                  recipe.thumbnail!,
                  height: height / 18,
                  width: width / 10,
                  fit: BoxFit.cover,
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

  Widget getTopList(
      double width, double height, List<Recipe> list, String title) {
    return Container(
      margin: EdgeInsets.only(top: height / 24),
      padding: EdgeInsets.fromLTRB(0, height / 200, 0, height / 200),
      height: height / 3,
      width: width - width / 15 * 2,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${title} TOP 5',
            style: TextStyle(
              fontSize: width / 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: width - width / 15 * 2 - width / 40 * 2,
            height: height / 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 5; i++)
                      Text(
                        list[i].title!.length < 22
                            ? '${i + 1}    ${list[i].title!}'
                            : '${i + 1}    ${list[i].title!.substring(0, 22)}...',
                        style: TextStyle(
                          fontSize: width / 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
              ],
            ),
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
            width: width * 0.85,
            child: TextFormField(
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 40, right: width / 40),
            child:
                IconButton(icon: Icon(Icons.search), onPressed: searchRecipe),
            // child: Icon(
            //   Icons.search,
            //   size: width / 15 > height / 27 ? width / 15 : height / 27,
            // ),
          ),
        ],
      ),
    );
  }

  void searchRecipe() {}
}
