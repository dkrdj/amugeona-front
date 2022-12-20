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
        '글제목',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
        30,
        DateTime(2021, 12, 21, 16, 24, 30),
        DateTime(2021, 12, 24, 15, 23, 10));

    List commentList = [];
    List replyList = [];

    for (int i = 0; i < 10; i++) {
      commentList.add(Comment(
          1 + i,
          1,
          2 + i,
          '댓글글쓴이$i',
          '댓글내용$i댓글내용$i댓글내용$i댓글내용$i댓글내용$i댓글내용$i',
          DateTime(2021, 12, 21 + i, 16, 24, 30),
          DateTime(2021, 12, 24 + i, 15, 23, 10)));
      replyList.add(ReplyComment(
          1 + i,
          1 + i,
          10 + i,
          '대댓글글쓴이$i',
          '대댓글내용$i대댓글내용$i대댓글내용$i대댓글내용$i대댓글내용$i',
          DateTime(2021, 12, 21 + i * 2, 16, 24, 30),
          DateTime(2021, 12, 24 + i * 2, 15, 23, 10)));
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(
        appBar: TopNav(),
        body: ListView(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          children: [],
        ),
      );
    });
  }
}
