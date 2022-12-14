import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopNav extends StatefulWidget with PreferredSizeWidget {
  const TopNav({super.key});

  @override
  _TopNav createState() => _TopNav();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TopNav extends State<TopNav> {
  bool _bellPressed = false;
  bool _settingPressed = false;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    IconData bell = IconData(0xf3e1,
        fontFamily: CupertinoIcons.iconFont,
        fontPackage: CupertinoIcons.iconFontPackage);

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      Icon bellIcon = Icon(
        bell,
        size: height,
        color: Colors.black38,
      );
      return Padding(
        padding: EdgeInsets.fromLTRB(width / 20, height / 4, width / 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                bell,
                size: height / 2,
                color: _bellPressed ? Colors.red : Colors.black,
              ),
              onPressed: bellPressed,
            ),
            Container(
              padding: EdgeInsets.only(
                top: height / 12,
                left: width / 20,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height / 8),
                    child: Text(
                      '현재 위치',
                      style: TextStyle(
                        fontSize: height / 4,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: height / 2.5,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: height / 2,
                color: _settingPressed ? Colors.pinkAccent : Colors.black,
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
      _settingPressed = !_settingPressed;
    });
  }

  void bellPressed() {
    setState(() {
      _bellPressed = !_bellPressed;
    });
  }
}
