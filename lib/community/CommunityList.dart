import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../appBar/TopNav.dart';
import '../item/Article.dart';
import 'CommunityDetail.dart';

class CommunityList extends StatefulWidget {
  const CommunityList({super.key, required this.value});

  final int value;

  @override
  State<CommunityList> createState() => _CommunityList();
}

Future<List<Article>> fetchArticle(int boardSeq, String orderby,
    int page) async {
  var uri = Uri.http('13.209.50.91:8080', 'articles', {
    'boardSeq': boardSeq.toString(),
    'orderBy': orderby,
    'page': page.toString()
  });

  final response = await http.get(uri, headers: {
    "access-token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
  });
  print("여기 오나");
  print(response.statusCode);
  if (response.statusCode == 200) {
    var list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    print("리스트");
    print(list);
    List<Article> a = list.map((article) => Article.fromJson(article)).toList();
    print(a);
    return list.map((article) => Article.fromJson(article)).toList();
  } else {
    throw Exception("데이터를 받아오지 못함");
  }
}

class _CommunityList extends State<CommunityList> {
  get login => null;
  String _selectedValue = '최근순';
  List<String> options = ['최근순', '조회순', '추천순', '댓글순'];

  late Future<List<Article>> popularArticle;
  late Future<List<Article>> article;

  @override
  void initState() {
    super.initState();
    popularArticle = fetchArticle(widget.value, 'articleLike', 0);
    article = fetchArticle(widget.value, 'articleSeq', 0);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      String keyword;
      if (widget.value == 1) {
        keyword = '맛집 추천';
      } else {
        keyword = '식단 자랑';
      }
      return Scaffold(
        appBar: TopNav(
          keyword: keyword,
          settingPressed: false,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          children: [
            Text(
              '${keyword}',
              style: TextStyle(
                fontSize: width / 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            // getList(width, height, restList, '맛집 추천'),
            FutureBuilder<List<Article>>(
                future: popularArticle,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getList(width, height, snapshot.data!, keyword);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            getOptionBar(width, height, options),
            FutureBuilder<List<Article>>(
                future: article,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        ...snapshot.data!.map(
                          (e) => getCard(width, height, e),
                        )
                      ],
                    );
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

  Widget getCard(double width, double height, Article article) {
    return Container(
      width: width - width / 12 * 2,
      height: height / 9,
      padding: EdgeInsets.fromLTRB(width / 30, 0, width / 30, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: height / 100),
                    child: Text(
                      article.title!.length < 15
                          ? article.title!
                          : '${article.title!.substring(0, 15)}...',
                      style: TextStyle(
                        fontSize: width / 25,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Text(
                    '${article.nickname}   조회 ${article.viewCnt}    작성일 ${article.createdAt}',
                    style: TextStyle(
                      fontSize: width / 40,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  Text(
                    '추천수',
                    style: TextStyle(
                        fontSize: width / 35, color: Colors.redAccent),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 80),
                    child: Text(
                      '${article.like}',
                      style: TextStyle(
                          fontSize: width / 40, color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          width: width - width / 12 * 2,
          height: 2,
          margin: EdgeInsets.only(top: height / 40),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black45, width: 1),
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

  Widget getList(
      double width, double height, List<Article> list, String title) {
    return Container(
      margin: EdgeInsets.only(top: height / 50),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0; i < 5; i++)
                      Text(
                        '${i + 1}.',
                        style: TextStyle(
                          fontSize: height / 40,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 5; i++)
                      GestureDetector(
                        child: Text(
                          list[i].title!.length < 8
                              ? list[i].title!
                              : '${list[i].title!.substring(0, 8)}...',
                          style: TextStyle(
                            fontSize: height / 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommunityDetail(
                                      value: list[i].articleSeq!)));
                        },
                      )
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 5; i < 10; i++)
                      Text(
                        '${i + 1}.',
                        style: TextStyle(
                          fontSize: height / 40,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 5; i < 10; i++)
                      Row(
                        children: [
                          Text(
                            list[i].title!.length < 8
                                ? list[i].title!
                                : '${list[i].title!.substring(0, 8)}...',
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
}
