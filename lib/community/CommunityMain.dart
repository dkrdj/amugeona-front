import 'package:flutter/material.dart';

import '../appBar/TopNav.dart';

class CommunityMain extends StatefulWidget {
  const CommunityMain({super.key});

  @override
  State<CommunityMain> createState() => _CommunityMain();
}

class _CommunityMain extends State<CommunityMain> {
  get login => null;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      List<String> restList = [];
      List<String> mealList = [];

      for (int i = 0; i < 10; i++) {
        restList.add('맛집${i + 1}입니다');
        mealList.add('식단${i + 1}입니다');
      }

      return Scaffold(
        appBar: TopNav(),
        body: Padding(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          child: ListView(
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
                        onPressed: null,
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
                        onPressed: null,
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
              getList(width, height, restList, '맛집 추천'),
              getList(width, height, mealList, '식단 자랑'),
            ],
          ),
        ),
      );
    });
  }

  Widget getList(double width, double height, List list, String title) {
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
                      Text(
                        list[i],
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
                            list[i],
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
