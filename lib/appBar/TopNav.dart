import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../user/MyPage.dart';

class TopNav extends StatefulWidget with PreferredSizeWidget {
  const TopNav(
      {super.key, required this.keyword, required this.settingPressed});

  final String keyword;
  final bool settingPressed;

  @override
  _TopNav createState() => _TopNav();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopNav extends State<TopNav> {
  bool _bellPressed = false;

  _TopNav();

  Widget buildText(double width, double height, String keyword) {
        return Padding(
          padding: EdgeInsets.only(top: height / 30),
          child: Text(
            keyword,
            style: TextStyle(
              fontSize: height / 4,
              color: Colors.black87,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    IconData bell = const IconData(0xf3e1,
        fontFamily: CupertinoIcons.iconFont,
        fontPackage: CupertinoIcons.iconFontPackage);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Padding(
        padding: EdgeInsets.fromLTRB(width / 20, height / 4, width / 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                bell,
                size: height / 2.5 > width / 12 ? width / 12 : height / 2.5,
                color: _bellPressed ? Colors.red : Colors.black54,
              ),
              onPressed: bellPressed,
            ),
            buildText(width, height, widget.keyword),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: height / 2.5 > width / 12 ? width / 12 : height / 2.5,
                color: widget.settingPressed ? Colors.red : Colors.black54,
              ),
              onPressed: settingPressed,
            )
          ],
        ),
      );
    });
  }

  void settingPressed() {
    setState(() {
      if (!widget.settingPressed) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyPage()));
      } else {
        Navigator.pop(context);
      }
    });
  }

  void bellPressed() {
    setState(() {
      _bellPressed = !_bellPressed;
    });
  }
}
