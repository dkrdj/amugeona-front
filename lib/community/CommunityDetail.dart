import 'package:amugeona/item/Comment.dart';
import 'package:amugeona/item/ReplyComment.dart';
import 'package:flutter/material.dart';

import '../appBar/TopNav.dart';
import '../item/Article.dart';

class CommunityDetail extends StatefulWidget {
  const CommunityDetail({Key? key}) : super(key: key);

  @override
  State<CommunityDetail> createState() => _CommunityDetailState();
}

class _CommunityDetailState extends State<CommunityDetail> {
  @override
  Widget build(BuildContext context) {
    Article article = Article(
        1,
        1,
        '글쓴이',
        1,
        '글 제목',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
        30,
        198,
        "assets/images/logo.png",
        DateTime(2021, 12, 1, 16, 24, 30),
        DateTime(2021, 12, 4, 15, 23, 10));

    List commentList = [];
    List replyList = [];
    List userList = [];

    for (int i = 0; i < 10; i++) {
      commentList.add(Comment(
          1 + i,
          1,
          2 + i,
          '댓닉네임$i',
          '댓글내용$i댓글내용$i댓글내용$i댓글내용$i댓글내용$i댓글내용$i',
          DateTime(2021, 12, 1 + i, 16, 24, 30),
          DateTime(2021, 12, 4 + i, 15, 23, 10)));
      replyList.add(ReplyComment(
          1 + i,
          1 + i,
          10 + i,
          '대댓닉네임$i',
          '대댓글내용$i대댓글내용$i대댓글내용$i대댓글내용$i대댓글내용$i',
          DateTime(2021, 12, 1 + i * 2, 16, 24, 30),
          DateTime(2021, 12, 4 + i * 2, 15, 23, 10)));
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(
        appBar: TopNav(),
        body: ListView(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          children: [
            Text(
              article.title,
              style: TextStyle(
                fontSize: width / 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height / 50),
              child: Text(
                article.nickname + ' | ' + article.createdAt.toString(),
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
              padding: EdgeInsets.only(top: height / 30, bottom: height / 30),
              child: Image(
                image: AssetImage(article.url),
                height: height / 4.8,
              ),
            ),
            Text(
              article.content,
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
            for (int i = 0; i < commentList.length; i++)
              getComment(commentList[i], width, height),
          ],
        ),
      );
    });
  }

  Widget getComment(Comment comment, double width, double height) {
    List replyList = [];
    for (int i = 0; i < 3; i++) {
      replyList.add(ReplyComment(
          1 + i,
          1 + i,
          10 + i,
          '대댓닉네임$i',
          '대댓글내용$i대댓글내용$i대댓글내용$i대댓글내용$i대댓글내용$i',
          DateTime(2021, 12, 1 + i * 2, 16, 24, 30),
          DateTime(2021, 12, 4 + i * 2, 15, 23, 10)));
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(width / 60, 0, width / 60, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                comment.nickname,
                style: TextStyle(
                  fontSize: width / 28,
                ),
              ),
              Text(
                '  ${comment.createdAt}',
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
              comment.content,
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
          for (int i = 0; i < 3; i++)
            getReplyComment(replyList[i], width, height),
        ],
      ),
    );
  }

  Widget getReplyComment(
      ReplyComment replyComment, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      replyComment.nickname,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width / 50, height / 100, 0, height / 100),
                  child: Text(
                    replyComment.content,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: width - width / 5,
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
      ],
    );
  }
}
