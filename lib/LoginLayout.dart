import 'package:flutter/material.dart';

class LoginLayout extends StatefulWidget {
  const LoginLayout({super.key});

  @override
  State<LoginLayout> createState() => _LoginLayout();
}

class _LoginLayout extends State<LoginLayout> {
  get login => null;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) { //BoxConstraints constraints : 반응형
      final double width = constraints.maxWidth;
      final double height = constraints.maxHeight;
      return Scaffold(  // return 할 객체 설명들 밑으로 쫙
        body: Center( //center 대신 container column 괜찮
          child: Column( // column & row 만 children을 넣을 수 있음
            children: <Widget>[
              Container(
                height: width / 5,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
                margin: EdgeInsets.only(top: height / 10, bottom: height / 70),
              ),
              Padding(
                padding: EdgeInsets.only(left: width / 60),
                child: Text(
                  'Amugeona',
                  style: TextStyle(
                    fontSize: width / 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.pinkAccent,
                    letterSpacing: width / 300,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        width / 8, height / 15, width / 8, 0),
                    child: Text(
                      '로그인',
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
                child: TextFormField( // 입력 인풋
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
              SizedBox(
                width: width - width / 4,
                height: height / 10,
                child: Padding(
                  padding: EdgeInsets.only(top: height / 30),
                  child: ElevatedButton( // 정해진 크기가 없기 때문색이 채워진 버튼
                    onPressed: login,
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height / 35),
                child: Text(
                  '혹은 소셜 계정으로 로그인하기',
                  style: TextStyle(
                    fontSize: width / 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        width / 8, height / 20, 0, height / 20),
                  ),
                  Container(
                    width: width / 2 - width / 8 - width / 40,
                    height: height / 17,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 229, 0, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(
                      right: width / 40,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: width / 25,
                        ),
                        Image.asset('assets/images/kakao.png',
                            width: width / 15),
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: width / 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width / 2 - width / 8 - width / 40,
                    height: height / 17,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(
                      left: width / 40,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: width / 25,
                        ),
                        Image.asset('assets/images/google.png',
                            width: width / 15),
                        SizedBox(
                          width: width / 20,
                        ),
                        Text(
                          '로그인',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: width / 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, height / 20, width / 8, height / 20),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        width / 8, height / 100, 0, height / 20),
                    child: Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        fontSize: width / 27,
                        fontWeight: FontWeight.w300,
                        color: Colors.black45,
                        letterSpacing: width / 350,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, height / 100, width / 8, height / 20),
                    child: Text(
                      '회원가입',
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
