import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_kakao_map/flutter_kakao_map.dart';
import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';

import '../appBar/TopNav.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantMain extends StatefulWidget {
  const RestaurantMain({super.key});

  @override
  State<RestaurantMain> createState() => _RestaurantMain();
}

const String mapKey = '121c47ef9eb22df63daf0f2f82ce51e0';

class _RestaurantMain extends State<RestaurantMain> {
  String _selectedValue1 = '지도중심';
  String _selectedValue2 = '관련도순';
  List<String> options1 = ['지도중심', '내위치중심'];
  List<String> options2 = ['관련도순', '거리순'];

  Completer<KakaoMapController> _controller = Completer();
  MapType _mapType = MapType.standard;
  CameraPosition _cameraPosition =
      CameraPosition(target: MapPoint(37.5087553, 127.0632877), zoom: 5);

  void _onMapCreated(KakaoMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(
        appBar: TopNav(),
        body: Padding(
              padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
              child: ListView(
            children: [
              searchBar(width - width / 15 * 2, height),
              kakaoMap(width - width / 15 * 2, height),
            ],
          ),
            ),
          );
        });
  }

  Widget kakaoMap(double width, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width,
        height: height,
        child: KakaoMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: _cameraPosition,
          mapType: _mapType,
        ),
      ),
    );
  }

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
