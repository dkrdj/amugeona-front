import 'package:flutter/material.dart';

class SignupLayout extends StatefulWidget {
  const SignupLayout({super.key});

  @override
  State<SignupLayout> createState() => _SignLayout();
}

class _SignLayout extends State<SignupLayout> {
  get login => null;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        width / 8, height / 15, width / 8, 0),
                    child: Text(
                      '회원가입',
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
                      'ID',
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
                      'Password',
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
                      'Password Check',
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
                      'Name',
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
                      'NickName',
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
                      'Email',
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
                      '회원가입',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(width / 8, height / 100, 0, 0),
                    child: Text(
                      '이미 계정이 있나요?',
                      style: TextStyle(
                        fontSize: width / 27,
                        fontWeight: FontWeight.w300,
                        color: Colors.black45,
                        letterSpacing: width / 350,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, height / 100, width / 8, 0),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: width / 27,
                        fontWeight: FontWeight.w300,
                        color: Colors.pinkAccent,
                        letterSpacing: width / 350,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
