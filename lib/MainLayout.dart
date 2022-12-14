import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayout();
}

class _MainLayout extends State<MainLayout> {
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
      ];
      final List<Article> articleList = <Article>[
        Article('오늘 먹은 식단 개쩔었던 썰 푼다', 203),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다2', 201),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다3', 198),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다4', 195),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다5', 190),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다6', 184),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다7', 176),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다8', 153),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다9', 120),
        Article('오늘 먹은 식단 개쩔었던 썰 푼다10', 89),
      ];

      return ListView(
        padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
        children: [
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
                  return Container(
                    height: height / 20,
                    child: Image.asset(imageList[idx]),
                  );
                },
              )),
          Text(
            '만들어 먹을까?',
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
          Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  for (int i = 0; i < articleList.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height / 30),
                          child: Text(
                            articleList[i].title,
                            style: TextStyle(
                              fontSize: width / 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height / 30),
                          child: Text(
                            '추천 ${articleList[i].likeCnt}',
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
            },
          ),
        ],
      );
    });
  }
}

class Article {
  String title;
  int likeCnt;

  Article(this.title, this.likeCnt);
}
