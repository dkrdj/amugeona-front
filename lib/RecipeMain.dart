import 'package:flutter/material.dart';

class RecipeMain extends StatefulWidget {
  const RecipeMain({super.key});

  @override
  State<RecipeMain> createState() => _RecipeMain();
}

class _RecipeMain extends State<RecipeMain> {
  get login => null;
  String _selectedValue = '최근순';
  List<String> options = ['최근순', '조회순', '추천순', '댓글순'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      List<String> recipeList = [];
      for (int i = 0; i < 10; i++) {
        recipeList.add('레시피${i + 1}입니다');
      }
      return Padding(
        padding: EdgeInsets.fromLTRB(width / 15, height / 30, width / 15, 0),
        child: Column(
          children: [
            searchBar(width - width / 15 * 2, height),
            getTopList(width, height, recipeList, '인기 레시피'),
            getOptionBar(width, height, options),
          ],
        ),
      );
    });
  }

  Widget getOptionBar(double width, double height, List<String> options) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DropdownButton<String>(
            value: _selectedValue,
            items: options.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
            iconSize: width / 15,
            onChanged: (val) {
              setState(() {
                _selectedValue = val!;
              });
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: width / 28,
            ),
            focusColor: Colors.black45,
            underline: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget getAllList(double width, double height, List list) {
    return ListView(
      children: [],
    );
  }

  Widget getTopList(double width, double height, List list, String title) {
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
            width: width * 0.86,
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
              size: width / 13 > height / 25 ? width / 13 : height / 25,
            ),
          ),
        ],
      ),
    );
  }
}
