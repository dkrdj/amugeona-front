import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../item/Recipe.dart';
import 'appBar/TopNav.dart';
import 'item/Article.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayout();
}

Future<List<Recipe>> fetchRecipe(String orderBy, int page) async {
  var uri = Uri.http('54.180.86.129:8080', 'recipe/list',
      {'orderBy': orderBy, 'page': page.toString()});

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    var list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Recipe> a = list.map((recipe) => Recipe.fromJson(recipe)).toList();
    return list.map((recipe) => Recipe.fromJson(recipe)).toList();
  } else {
    throw Exception("데이터를 받아오지 못함");
  }
}

Future<List<Article>> fetchArticle(String orderBy, int page) async {
  var uri = Uri.http('54.180.86.129:8080', 'article/listAll',
      {'orderBy': orderBy, 'page': page.toString()});

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    var list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Article> a = list.map((article) => Article.fromJson(article)).toList();
    return list.map((article) => Article.fromJson(article)).toList();
  } else {
    throw Exception("데이터를 받아오지 못함");
  }
}

class _MainLayout extends State<MainLayout> {
  late Future<List<Recipe>> recipe;

  // late Future<List<Article>> article;

  @override
  void initState() {
    super.initState();
    recipe = fetchRecipe('starRating', 0);
    // article = fetchArticle('createdAt', 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      final List<String> imageList = <String>[
        'assets/images/logo.png',
        'assets/images/logo.png',
        'assets/images/logo.png',
        'assets/images/logo.png',
        'assets/images/logo.png',
        'assets/images/logo.png',
      ];
      String keyword = '현재 위치';
      return Scaffold(
        appBar: TopNav(
          keyword: keyword,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          children: [
            Text(
              '만들어 먹을까?',
              style: TextStyle(
                fontSize: width / 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            FutureBuilder<List<Recipe>>(
                future: recipe,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getImg(width, height, snapshot.data!);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Text(
              '오늘은 뭘 먹을까?',
              style: TextStyle(
                fontSize: width / 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
                height: height / 8,
                margin: EdgeInsets.only(top: height / 30, bottom: height / 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageList.length,
                  itemBuilder: (BuildContext context, int idx) {
                    return SizedBox(
                      height: height / 20,
                      child: Image.asset(imageList[idx]),
                    );
                  },
                )),
            Text(
              '최근 주목 받는 글',
              style: TextStyle(
                fontSize: width / 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            // FutureBuilder<List<Article>>(
            //     future: article,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return getArticle(width, height, snapshot.data!);
            //       }
            //       return Text('dd');
            //       // return const Center(
            //       //   child: CircularProgressIndicator(),
            //       // );
            //     }),
          ],
        ),
      );
    });
  }

  Widget getArticle(double width, double height, List<Article> article) {
    return Column(
      children: [
        for (int i = 0; i < article!.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height / 30),
                child: Text(
                  article[i].title!,
                  style: TextStyle(
                    fontSize: width / 30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height / 30),
                child: Text(
                  '추천 ${article[i].like}',
                  style: TextStyle(
                    fontSize: width / 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget getImg(double width, double height, List<Recipe> recipe) {
    return Container(
        height: height / 4,
        margin: EdgeInsets.only(top: height / 30, bottom: height / 30),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipe.length,
            itemBuilder: (BuildContext context, int idx) {
              return Container(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        recipe[idx].thumbnail!,
                        height: height / 6,
                        width: width / 3,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        color: Colors.black12,
                        width: width / 3,
                        height: height / 25,
                        child: Text(
                          recipe[idx].title!.length < 10
                              ? recipe[idx].title!
                              : '${recipe[idx].title!.substring(0, 10)}...',
                          style: TextStyle(
                            fontSize: width / 32,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
