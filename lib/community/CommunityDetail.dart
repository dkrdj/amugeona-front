import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../appBar/TopNav.dart';
import '../item/Article.dart';
import '../item/Comment.dart';
import '../item/ReplyComment.dart';

class CommunityDetail extends StatefulWidget {
  const CommunityDetail({Key? key, required this.value, required this.boardSeq})
      : super(key: key);
  final int value;
  final int boardSeq;

  @override
  State<CommunityDetail> createState() => _CommunityDetailState();
}

Future<Article> fetchArticle(int articleSeq) async {
  var uri = Uri.http('13.209.50.91:8080', 'article/$articleSeq');

  final response = await http.get(uri, headers: {
    "access-token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
  });

  if (response.statusCode == 200) {
    var article = jsonDecode(utf8.decode(response.bodyBytes));
    return Article.fromJson(article);
  } else {
    throw Exception("데이터 못받아옴");
  }
}

Future<Map<String, dynamic>> fetchComment(int articleSeq, int page) async {
  var uri = Uri.http('13.209.50.91:8080', 'comments',
      {'articleSeq': articleSeq.toString(), 'page': page.toString()});

  final response = await http.get(uri, headers: {
    "access-token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
  });

  if (response.statusCode == 200) {
    var list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Comment> commentList = list.map((e) => Comment.fromJson(e)).toList();

    List<ReplyComment> replyList = [];

    for (Comment comment in commentList) {
      var replyUri = Uri.http('13.209.50.91:8080', 'replies',
          {'rootSeq': comment.commentSeq.toString(), 'page': page.toString()});

      final replyResponse = await http.get(replyUri, headers: {
        "access-token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyU2VxIjo1LCJpZCI6InVzZXIxIiwibmFtZSI6InVzZXIxIiwibmlja25hbWUiOiJ1c2VyMSJ9.DOcF2SQksHPCTZfxPrjJO0CbYl2oQ205f3tslMvbcO4"
      });

      if (replyResponse.statusCode == 200) {
        var reply = jsonDecode(utf8.decode(replyResponse.bodyBytes)) as List;
        List<ReplyComment> a =
            reply.map((e) => ReplyComment.fromJson(e)).toList();
        replyList.addAll(a);
      }
    }
    Map<String, dynamic> map = {};
    map['comment'] = commentList;
    map['reply'] = replyList;
    return map;
  } else {
    throw Exception("comment 데이터 못받아옴");
  }
}

class _CommunityDetailState extends State<CommunityDetail> {
  late Future<Article> article;
  late Future<List<Comment>> comment;
  late Future<List<ReplyComment>> reply;

  @override
  void initState() {
    super.initState();
    Future<Map<String, dynamic>> map = fetchComment(widget.value, 0);
    article = fetchArticle(widget.value);
    reply = map.then((value) => value['reply']);
    comment = map.then((value) => value['comment']);
  }

  @override
  Widget build(BuildContext context) {
    String keyword;

    if (widget.boardSeq == 1) {
      keyword = '맛집 추천';
    } else {
      keyword = '식단 자랑';
    }

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
            padding:
                EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
            children: [
              FutureBuilder<Article>(
                future: article,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getDetail(width, height, snapshot.data!);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder<List<Comment>>(
                  future: comment,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          ...snapshot.data!
                              .map((e) => getComment(e, width, height))
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ));
    });
  }

  Widget getDetail(double width, double height, Article article) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title!,
              style: TextStyle(
                fontSize: width / 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.only(top: height / 100),
              child: Text(
                '${article.nickname!} | ${article.createdAt}',
                style: TextStyle(
                  fontSize: width / 30,
                ),
              ),
            ),
            Text(
              '조회 : ${article.viewCnt} | 추천 : ${article.like}',
              style: TextStyle(
                fontSize: width / 30,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: height / 30),
              child: Text(
                '[ ${article.info} ]',
                style: TextStyle(
                  fontSize: width / 30,
                ),
              ),
            ),
            Text(
              article.content!,
              style: TextStyle(
                fontSize: width / 25,
                height: 1.5,
              ),
            ),
            Container(
              width: width - width / 15 * 2,
              margin: EdgeInsets.only(top: height / 40, bottom: height / 70),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 3.5,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height / 100),
              child: Text(
                '댓글',
                style: TextStyle(
                  fontSize: width / 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ));
  }

  Widget getComment(Comment comment, double width, double height) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width / 60, 0, width / 60, 0),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  comment.nickname!,
                  style: TextStyle(
                    fontSize: width / 28,
                  ),
                ),
                Text(
                  comment.createdAt!,
                  style: TextStyle(
                    fontSize: width / 40,
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(width / 50, height / 100, 0, height / 100),
              child: Text(
                comment.content!,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(width / 40, 0, 0, height / 100),
              width: width / 8,
              height: height / 40,
              child: OutlinedButton(
                onPressed: null,
                child: Text('답글'),
              ),
            ),
            FutureBuilder<List<ReplyComment>>(
                future: reply,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        ...snapshot.data!.map((e) {
                          if (e.rootSeq == comment.commentSeq) {
                            return getReplyComment(
                                e, width, height, comment.commentSeq!);
                          } else {
                            return Container();
                          }
                        })
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Container(
              width: width - width / 15 * 2,
              margin: EdgeInsets.only(top: height / 200, bottom: height / 100),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getReplyComment(
      ReplyComment replyComment, double width, double height, int commentSeq) {
    return Padding(
      padding: EdgeInsets.only(left: width / 50),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: width - width / 7,
              margin: EdgeInsets.only(top: height / 200, bottom: height / 100),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black26,
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: height / 200),
                  child: Icon(
                    Icons.subdirectory_arrow_right,
                    size: width / 25,
                    color: Colors.black45,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            replyComment.nickname!,
                            style: TextStyle(
                              fontSize: width / 28,
                            ),
                          ),
                          Text(
                            '  ${replyComment.createdAt}',
                            style: TextStyle(
                              fontSize: width / 40,
                            ),
                          )
                        ],
                      ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              width / 50, height / 100, 0, height / 100),
                          child: Text(
                            replyComment.content!,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
