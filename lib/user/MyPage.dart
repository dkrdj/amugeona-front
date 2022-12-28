import 'package:amugeona/item/Inbody.dart';
import 'package:amugeona/item/Inedible.dart';
import 'package:amugeona/item/User.dart';
import 'package:flutter/material.dart';

import '../appBar/TopNav.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    User user = User(1, 'id', 'password', '1379psm@naver.com', 25, '삭수민',
        '플젝안하냐', 'assets/images/sumin.jpg');
    String keyword = '마이페이지';
    List inedibleList = [];
    inedibleList.add(Inedible(1, 1, '삭수민'));
    inedibleList.add(Inedible(2, 1, '프로젝트'));
    inedibleList.add(Inedible(3, 1, '안하냐'));
    inedibleList.add(Inedible(4, 1, '좀 해라'));
    inedibleList.add(Inedible(5, 1, '힘들다'));
    Inbody inbody = Inbody(1, 175, 54, 45, 2);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(
        appBar: TopNav(
          keyword: keyword,
          settingPressed: true,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(width / 15, height / 60, width / 15, 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '비밀번호 변경',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: width / 32,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: width / 10,
              height: height / 6,
              child: Image.asset(user.profileImg),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width / 25,
                    height: height / 200,
                  ),
                  Text(
                    '${user.nickname}  ',
                    style: TextStyle(
                      fontSize: width / 28,
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    size: width / 25,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width / 25,
                    height: height / 200,
                  ),
                  Text(
                    '${user.email}  ',
                    style: TextStyle(
                      fontSize: width / 28,
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    size: width / 25,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 17, bottom: height / 40),
              child: Row(
                children: [
                  Text(
                    '못 먹는 재료 ',
                    style: TextStyle(
                      fontSize: width / 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.info_outline_rounded,
                    size: width / 20,
                  ),
                ],
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              children: [
                for (int i = 0; i < inedibleList.length; i++)
                  getCard(width, height, inedibleList[i].name),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: height / 17, bottom: height / 40, right: width / 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '인바디',
                    style: TextStyle(
                      fontSize: width / 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.edit,
                    size: width / 20,
                  ),
                ],
              ),
            ),
            getInbody(width, height, inbody.height, '키'),
            getInbody(width, height, inbody.weight, '체중'),
            getInbody(width, height, inbody.muscle, '골격근량'),
            getInbody(width, height, inbody.fat, '체지방량'),
          ],
        ),
      );
    });
  }

  Widget getInbody(double width, double height, double num, String category) {
    String unit = 'kg';
    if (category == '키') {
      unit = 'cm';
    }
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width / 1.7,
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: width / 22,
                  ),
                ),
              ),
              Container(
                width: width / 6,
                child: Text(
                  num.toString(),
                  style: TextStyle(
                    fontSize: width / 22,
                  ),
                ),
              ),
              Container(
                child: Text(
                  unit,
                  style: TextStyle(
                    fontSize: width / 22,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin:
                EdgeInsets.fromLTRB(0, height / 100, width / 30, height / 100),
            width: width - width / 15 * 2 - width / 30,
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black45)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getCard(double width, double height, String name) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          width / 40, height / 200, width / 40, height / 200),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(width / 20),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,
        spacing: width / 100,
        children: [
          Text(
            '$name',
            style: TextStyle(
              fontSize: width / 30,
            ),
          ),
          Icon(
            Icons.close,
            size: width / 30,
          )
        ],
      ),
    );
  }
}
