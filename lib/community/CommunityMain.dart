import 'dart:convert';

import 'package:amugeona/community/CommunityList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../appBar/TopNav.dart';
import '../community/CommunityDetail.dart';
import '../item/Article.dart';

class CommunityMain extends StatefulWidget {
  const CommunityMain({super.key});

  @override
  State<CommunityMain> createState() => _CommunityMain();
}

Future<List<Article>> fetchArticle(
    int boardSeq, String orderBy, int page) async {
  var uri = Uri.http('13.209.50.91:8080', 'articles', {
    'boardSeq': boardSeq.toString(),
    'orderBy': orderBy,
    'page': page.toString()
  });

  final response = await http.get(uri, headers: {
    "access-token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
  });

  if (response.statusCode == 200) {
    var list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Article> a = list.map((article) => Article.fromJson(article)).toList();
    return list.map((article) => Article.fromJson(article)).toList();
  } else {
    throw Exception("데이터를 받아오지 못함");
  }
}

class _CommunityMain extends State<CommunityMain> {
  get login => null;

  late Future<List<Article>> restaurantArticle;
  late Future<List<Article>> recipeArticle;

  @override
  void initState() {
    super.initState();
    restaurantArticle = fetchArticle(1, 'articleLike', 0);
    recipeArticle = fetchArticle(2, 'articleLike', 0);
  }

  @override
  Widget build(BuildContext context) {
    int restaurantArticleSeq = 1;
    int recipeArticleSeq = 2;
    String keyword = '커뮤니티';
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;

      return Scaffold(
        appBar: TopNav(
          keyword: keyword,
          settingPressed: false,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: width / 2 - width / 15 * 2,
                  height: height / 16,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommunityList(
                                    value: restaurantArticleSeq)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width / 25),
                            child: Text(
                              '맛집 추천',
                              style: TextStyle(
                                fontSize: width / 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: width / 15,
                            color: Colors.black,
                          ),
                        ],
                      )),
                ),
                Container(
                  width: width / 2 - width / 15 * 2,
                  height: height / 16,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: OutlinedButton(
                      onPressed: recipePressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: width / 25),
                            child: Text(
                              '식단 자랑',
                              style: TextStyle(
                                fontSize: width / 22,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            size: width / 15,
                            color: Colors.black,
                          ),
                        ],
                      )),
                ),
              ],
            ),
            FutureBuilder(
                future: restaurantArticle,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getList(width, height, snapshot.data!, '맛집 추천');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            FutureBuilder(
                future: recipeArticle,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getList(width, height, snapshot.data!, '식단 자랑');
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      );
    });
  }

  Widget getList(
      double width, double height, List<Article> list, String title) {
    return Container(
      margin: EdgeInsets.only(top: height / 15),
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
            '${title} TOP 10',
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
                        list[i].title!.length < 6
                            ? '${i + 1}    ${list[i].title!}'
                            : '${i + 1}    ${list[i].title!.substring(0, 6)}...',
                        style: TextStyle(
                          fontSize: height / 40,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
                Container(
                  width: 1,
                  height: height / 4,
                  margin: EdgeInsets.only(left: width / 30),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black38,
                    width: 1.4,
                  )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 5; i < 10; i++)
                      Row(
                        children: [
                          Text(
                            list[i].title!.length < 6
                                ? '${i + 1}    ${list[i].title!}'
                                : '${i + 1}    ${list[i].title!.substring(0, 6)}...',
                            style: TextStyle(
                              fontSize: height / 40,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                        ],
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

  // void restaurantPressed(Long boardSeq) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => CommunityDetail(value: boardSeq)));
  // }

  void recipePressed() {}
}
