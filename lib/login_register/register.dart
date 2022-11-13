import 'dart:convert';

import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/main.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import '../home.dart';
import '../partnner_custom.dart';
import 'login.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Login()),
    );
  }
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = sizeMH(context);
    String username = "";
    String password = "";
    String name = "";
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images_lt/login-1.png'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.vertical,
          child: Column(children: [
            // Image.network(
            //     fit: BoxFit.cover,
            //     height: size.height * 0.4,
            //     "https://3.bp.blogspot.com/-y9kpCo82zjI/VearjMoMZrI/AAAAAAAAGlI/h9VNIuwtkSY/s1600/tai-hinh-nen-may-tinh-dep-nhung-dam-may-hinh-trai-tim-tren-bau-troi-467856.jpg"),
            addVertical(size: size.height * 0.2),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text("Đăng ký", style: textTheme(context).headline4),
            ),
            const addVertical(size: 10),
            TextField(
              decoration: InputDecoration(hintText: "Tài khoản"),
              onChanged: (a) {
                username = a;
              },
            ),
            const addVertical(size: 10),
            TextField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(hintText: "Mật khẩu"),
              onChanged: (a) {
                password = a;
              },
            ),
            const addVertical(size: 10),
            TextField(
              decoration: InputDecoration(hintText: "Họ và tên"),
              onChanged: (a) {
                name = a;
              },
            ),
            const addVertical(size: 20),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                  "Để đăng ký, bạn đồng ý với Điều khoản & Điều kiện và Chính sách Cung cấp của chúng tôi"),
            ),
            addVertical(size: 20),
            Container(
                // margin: EdgeInsets.symmetric(horizontal: 20),
                width: size.height * 0.5, // <-- match_parent
                // height: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (await checkStatus()) {
                        if (await register1(username, password, name) == 200) {
                          toast('Đăng ký thành công', Colors.green);
                          // idUserCurrent = username;
                          ontapChuyenMH(LoginWidget(), context);
                        }
                      } else {
                        toast("Bạn chưa kết nối internet", Colors.red);
                      }
                    },
                    child: Text("Đăng ký"))),
            addVertical(size: 10),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: "Bạn đã có tài khoản?",
                  style: TextStyle(color: Colors.black)),
              WidgetSpan(
                  child: InkWell(
                onTap: () => ontapChuyenMH(const LoginWidget(), context),
                child: Text('Đăng nhập', style: TextStyle(color: Colors.blue)),
              ))
            ]))
          ]),
        ),
      ),
    );
  }
}

Future<int> register1(String username, String password, String name) async {
  var url = Uri.parse('http://' + IP + '/account/register');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'username': username,
        'password': password
      }));

  return response.statusCode;
}
