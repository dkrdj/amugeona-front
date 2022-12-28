import 'package:flutter/material.dart';

import '../appBar/TopNav.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantMain extends StatefulWidget {
  const RestaurantMain({super.key});

  @override
  State<RestaurantMain> createState() => _RestaurantMain();
}

class _RestaurantMain extends State<RestaurantMain> {
  String _selectedValue1 = '지도중심';
  String _selectedValue2 = '관련도순';
  List<String> options1 = ['지도중심', '내위치중심'];
  List<String> options2 = ['관련도순', '거리순'];

  @override
  Widget build(BuildContext context) {
    String keyword = '현재 위치';
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(
        appBar: TopNav(
          keyword: keyword,
          settingPressed: false,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
          child: Column(
            children: [
              searchBar(width - width / 15 * 2, height),
            ],
          ),
        ),
      );
    });
  }

// Widget kakaoMap(double width, double height) {
//   return Container(
//     width: width / 3 * 2,
//     height: height / 2,
//     child: KakaoMap(
//       onMapCreated: onMapCreated,
//       initialCameraPosition: _kInitialPosition,
//       mapType: MapType.standard,
//     ),
//   );
// }

  Widget searchBar(double width, double height) {
    return Container(
      width: width,
      height: height / 19,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: width / 15),
            width: width * 0.85,
            child: TextFormField(
              decoration: const InputDecoration(
                focusedBorder: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width / 40, right: width / 40),
            child: Icon(
              Icons.search,
              size: width / 15 > height / 27 ? width / 15 : height / 27,
            ),
          ),
        ],
      ),
    );
  }
}
