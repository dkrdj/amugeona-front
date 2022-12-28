// import 'package:flutter/material.dart';
//
// import '../appBar/TopNav.dart';
// import '../item/Article.dart';
//
// class CommunityList extends StatefulWidget {
//   const CommunityList({super.key, required this.boardSeq});
//
//   final int boardSeq;
//
//   @override
//   State<CommunityList> createState() => _CommunityList();
// }
//
// class _CommunityList extends State<CommunityList> {
//   get login => null;
//   String _selectedValue = '최근순';
//   List<String> options = ['최근순', '조회순', '추천순', '댓글순'];
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       final double width = constraints.maxWidth;
//       final double height = constraints.maxHeight;
//       List<String> restList = [];
//       List articleList = [];
//       for (int i = 0; i < 10; i++) {
//         restList.add('맛집${i + 1}입니다');
//         articleList.add(Article(
//             1 + i,
//             1 + i,
//             '글쓴이$i',
//             1,
//             '제목$i',
//             '',
//             i * 15,
//             i * 50,
//             'assets/images/logo.png',
//             DateTime(2021, 12, 1, 16, 24, 30),
//             DateTime(2021, 12, 4, 15, 23, 10)));
//       }
//       String keyword;
//       if (widget.boardSeq == 1) {
//         keyword = '맛집 추천';
//       } else {
//         keyword = '식단 자랑';
//       }
//       return Scaffold(
//         appBar: TopNav(
//           keyword: keyword,
//         ),
//         body: ListView(
//           padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
//           children: [
//             Text(
//               '식단 자랑',
//               style: TextStyle(
//                 fontSize: width / 15,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             getList(width, height, restList, '맛집 추천'),
//             getOptionBar(width, height, options),
//             for (int i = 0; i < 10; i++)
//               getCard(width, height, articleList[i], i)
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget getCard(double width, double height, Article article, int idx) {
//     return Container(
//       width: width - width / 12 * 2,
//       height: height / 9,
//       padding: EdgeInsets.fromLTRB(width / 30, 0, width / 30, 0),
//       child: Column(children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(bottom: height / 100),
//                   child: Text(
//                     article.title,
//                     style: TextStyle(
//                       fontSize: width / 25,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                         right: width / 50,
//                       ),
//                       child: Text(
//                         '${article.nickname}   조회 ${article.viewCnt}',
//                         style: TextStyle(
//                           fontSize: width / 40,
//                           color: Colors.black,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: width / 50),
//                       child: Text(
//                         '추천 ${article.like}',
//                         style:
//                             TextStyle(fontSize: width / 40, color: Colors.red),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: width / 40),
//                       child: Text(
//                         '댓글 ${article.like}',
//                         style: TextStyle(
//                             fontSize: width / 40, color: Colors.blueAccent),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   article.url,
//                   height: height / 18,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         Container(
//           width: width - width / 12 * 2,
//           height: 2,
//           margin: EdgeInsets.only(top: height / 40),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black45, width: idx == 9 ? 0 : 1),
//           ),
//         )
//       ]),
//     );
//   }
//
//   Widget getOptionBar(double width, double height, List<String> options) {
//     return Container(
//       margin: EdgeInsets.only(
//         bottom: height / 50,
//         top: height / 70,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           DropdownButton<String>(
//             value: _selectedValue,
//             items: options.map((value) {
//               return DropdownMenuItem(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
//             iconSize: width / 15,
//             onChanged: (val) {
//               setState(() {
//                 _selectedValue = val!;
//               });
//             },
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: width / 28,
//             ),
//             focusColor: Colors.black45,
//             underline: SizedBox.shrink(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget getList(double width, double height, List list, String title) {
//     return Container(
//       margin: EdgeInsets.only(top: height / 50),
//       padding: EdgeInsets.fromLTRB(0, height / 200, 0, height / 200),
//       height: height / 3,
//       width: width - width / 15 * 2,
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 2,
//           color: Colors.black,
//         ),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             '${title} TOP 10',
//             style: TextStyle(
//               fontSize: width / 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Container(
//             width: width - width / 15 * 2 - width / 40 * 2,
//             height: height / 4,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     for (int i = 0; i < 5; i++)
//                       Text(
//                         '${i + 1}.',
//                         style: TextStyle(
//                           fontSize: height / 40,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black87,
//                         ),
//                       ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (int i = 0; i < 5; i++)
//                       Text(
//                         list[i],
//                         style: TextStyle(
//                           fontSize: height / 40,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black87,
//                         ),
//                       ),
//                   ],
//                 ),
//                 Container(
//                   width: 1,
//                   height: height / 4,
//                   margin: EdgeInsets.only(left: width / 30),
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                     color: Colors.black38,
//                     width: 1.4,
//                   )),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     for (int i = 5; i < 10; i++)
//                       Text(
//                         '${i + 1}.',
//                         style: TextStyle(
//                           fontSize: height / 40,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.black87,
//                         ),
//                       ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (int i = 5; i < 10; i++)
//                       Row(
//                         children: [
//                           Text(
//                             list[i],
//                             style: TextStyle(
//                               fontSize: height / 40,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
