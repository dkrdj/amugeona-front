import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:http/http.dart' as http;

import '../appBar/TopNav.dart';
import '../item/Restaurant.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantMain extends StatefulWidget {
  const RestaurantMain({super.key});

  @override
  State<RestaurantMain> createState() => _RestaurantMain();
}

Future<Position> getCurrentLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}
Future<Map<String, dynamic>> fetchRestaurant(double lng, double lat) async {
  if(lng <1){
    await getCurrentLocation().then((val) {
      lng = val.longitude;
      lat = val.latitude;
    });
  }
  var uri = Uri.http('13.209.50.91:8080', 'restaurants',
      {'longitude': lng.toString(), 'latitude': lat.toString()});
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    var list = jsonDecode(utf8.decode(response.bodyBytes)) as List;
    List<Restaurant> resList = list.map((restaurant) => Restaurant.fromJson(restaurant)).toList();
    List<Marker> markerList = resList.map((restaurant)=> Marker(markerId: restaurant.restaurantSeq!.toString(), position: LatLng(restaurant.latitude, restaurant.longitude), infoWindow: restaurant.title)).toList();
    Map<String, dynamic> map = {};
    map['resList'] = resList;
    map['markerList'] = markerList;
    return map;
  } else {
    throw Exception("데이터를 받아오지 못함");
  }

}

class _RestaurantMain extends State<RestaurantMain> {
  String _selectedValue1 = '지도중심';
  String _selectedValue2 = '관련도순';
  List<String> options1 = ['지도중심', '현재위치'];
  List<String> options2 = ['관련도순', '거리순'];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();
  double lng = 0.0;
  double lat = 0.0;

  late Future<List<Restaurant>> resList;
  late Future<List<Marker>> markerList;

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((val) {
      lng = val.longitude;
      lat = val.latitude;
    });
    Future<Map<String, dynamic>> map = fetchRestaurant(lng, lat);
    resList = map.then((value)=>value['resList']);
    markerList = map.then((value)=>value['markerList']);
  }

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
        body: SnappingSheet(
          grabbingHeight: height / 20,
          grabbing: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height / 40),
                topRight: Radius.circular(height / 40),
              ),
              border: Border.all(width: 1, color: Colors.black12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width / 8,
                  height: 2.5,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.25, color: Colors.black45),
                    borderRadius: const BorderRadius.all(Radius.circular(0.5)),
                  ),
                )
              ],
            ),
          ),
          snappingPositions: const [
            SnappingPosition.factor(
              positionFactor: 0.28,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: Duration(milliseconds: 500),
              grabbingContentOffset: GrabbingContentOffset.top,
            ),
            SnappingPosition.factor(
              positionFactor: 0.5,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: Duration(milliseconds: 500),
            ),
            SnappingPosition.factor(
              positionFactor: 0.8,
              snappingCurve: Curves.easeOutExpo,
              snappingDuration: Duration(milliseconds: 500),
              grabbingContentOffset: GrabbingContentOffset.bottom,
            ),
          ],
          sheetBelow: SnappingSheetContent(
            sizeBehavior: SheetSizeStatic(size: 300),
            draggable: true,
            child: FutureBuilder<List<Restaurant>>(
              future: resList,
              builder:(context, snapshot) {
                if(snapshot.hasData){
                  return Container(
                    color: Colors.white,
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                          width / 15, height / 100, width / 15, 0),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getOptionBar(width, height, options1, _selectedValue1,
                                    (str) {
                                  setState(() {
                                    _selectedValue1 = str;
                                  });
                                }),
                          ],
                        ),
                        ...snapshot.data!.map((e) => getCard(width, height, e)),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },

            ),
          ),
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
            child: Column(
              children: [
                searchBar(width - width / 15 * 2, height),
                Container(
                  width: width - width / 15 * 2,
                  height: height / 2,
                  margin: EdgeInsets.only(
                    top: height / 25,
                  ),
                  child: FutureBuilder<List<Marker>>(
                    future: markerList,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return NaverMap(
                          initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 16.0),
                          onMapCreated: _onMapCreated,
                          locationButtonEnable: true,
                          markers: snapshot.data!,
                          onCameraChange: (latLng, reason, isAnimated) {
                            setState(() {
                              lat = latLng.latitude;
                              lng = latLng.longitude;
                            });
                          },
                          onCameraIdle: () {
                            setState(() {
                              Future<
                                  Map<String, dynamic>> map = fetchRestaurant(
                                  lng, lat);
                              resList = map.then((value) => value['resList']);
                              markerList =
                                  map.then((value) => value['markerList'])
                                      .then((value) => value);
                            });
                          },
                        );
                      }
                      else{
                        return Container();
                      }
                    },
                  )
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  Widget getOptionBar(double width, double height, List<String> options,
      String selectedValue, Function(String str) f) {
    return Container(
      width: width / 4,
      margin: EdgeInsets.only(
        bottom: height / 100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: selectedValue,
            items: options.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            iconSize: width / 15,
            onChanged: (val) {
              f(val!);
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: width / 28,
            ),
            focusColor: Colors.black45,
            underline: const SizedBox.shrink(),
          ),
        ],
      ),
    );
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

  Widget getCard(double width, double height, Restaurant restaurant) {
    double dist = getDist(lat, lng, restaurant.latitude!, restaurant.longitude!);
    String distance = "";
    if (dist > 1000.0) {
      dist = dist / 1000;
      distance = '${dist.toStringAsFixed(1)}km';
    } else {
      distance = '${dist.round()}m';
    }
    return Container(
      height: height / 9,
      margin: EdgeInsets.only(
        bottom: height / 100,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        restaurant.title!,
                        style: TextStyle(
                          fontSize: width / 28,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: width / 70,
                          bottom: height / 400,
                        ),
                        child: Text(
                          restaurant.category!,
                          style: TextStyle(
                            fontSize: width / 40,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: width / 100,
                        ),
                        child: Text(
                          restaurant.starRating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: width / 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      RatingBarIndicator(
                        rating: double.parse(
                            restaurant.starRating!.toStringAsFixed(1)),
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        unratedColor: Colors.white,
                        itemSize: width / 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width / 100),
                        child: Text(
                          '(${restaurant.starCnt})',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: width / 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        distance,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width / 100),
                        child: Text(
                          restaurant.address!.length < 23
                              ? restaurant.address!
                              : '${restaurant.address!.substring(0, 23)}...',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    restaurant.number==null ? '정보 없음':restaurant.number!,
                    // '정보 없음',
                    style: const TextStyle(
                      color: CupertinoColors.activeBlue,
                    ),
                  )
                ],
              ),
              Image.network(
                'https://img.siksinhot.com/place/1376432165369645.png?w=540&h=436&c=Y',
                height: height / 12,
                width: height / 12,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: height / 50),
            width: width - width / 15 * 2,
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(width: 1, color: Colors.black54))),
          )
        ],
      ),
    );
  }

  double getDist(double lat1, double lng1, double lat2, double lng2) {
    double theta = lng1 - lng2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    return rad2deg(acos(dist)) * 60 * 1.1515 * 1609.344;
  }

  double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double rad2deg(double rad) {
    return (rad * 180 / pi);
  }
}