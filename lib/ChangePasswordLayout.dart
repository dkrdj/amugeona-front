import 'package:flutter/material.dart';

class ChangePasswordLayout extends StatefulWidget {
  const ChangePasswordLayout({super.key});

  @override
  State<ChangePasswordLayout> createState() => _ChangePasswordLayout();
}

class _ChangePasswordLayout extends State<ChangePasswordLayout> {
  get login => null;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;

      return Center(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(width / 8, height / 15, width / 8, 0),
                  child: Text(
                    '비밀번호 변경',
                    style: TextStyle(
                      fontSize: width / 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: width / 200,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width / 8, height / 20, width / 8, height / 100),
                  child: Text(
                    '현재 비밀번호',
                    style: TextStyle(
                      fontSize: width / 36,
                      fontWeight: FontWeight.w400,
                      color: Colors.pinkAccent,
                      letterSpacing: width / 500,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width / 8, 0, width / 8, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black26,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width / 8, height / 20, width / 8, height / 100),
                  child: Text(
                    '새 비밀번호',
                    style: TextStyle(
                      fontSize: width / 36,
                      fontWeight: FontWeight.w400,
                      color: Colors.pinkAccent,
                      letterSpacing: width / 500,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width / 8, 0, width / 8, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black26,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width / 8, height / 20, width / 8, height / 100),
                  child: Text(
                    '새 비밀번호 확인',
                    style: TextStyle(
                      fontSize: width / 36,
                      fontWeight: FontWeight.w400,
                      color: Colors.pinkAccent,
                      letterSpacing: width / 500,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width / 8, 0, width / 8, 0),
              child: TextFormField(
                decoration: const InputDecoration(
                  isDense: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black26,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width - width / 4,
              height: height / 10,
              child: Padding(
                padding: EdgeInsets.only(top: height / 30),
                child: ElevatedButton(
                  onPressed: login,
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
