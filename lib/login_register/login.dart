import 'dart:convert';
import 'dart:io';

import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/database/database.dart';
import 'package:design_flutter_ui_4/login_register/register.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import '../home.dart';
import '../models/models.dart';
import 'resetPassword.dart';



GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);



class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String token = "";
  GoogleSignInAccount? _currentUser;
  @override
  void initState() {
    getToken(MyApp(), context);
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        // _handleGetContact(_currentUser!);
        // _googleSignIn.signInSilently();
        print(_currentUser!.displayName);
        print(_currentUser!.email);
        print(_currentUser!.photoUrl);
      }
    });
  }

  Future<void> _handleSignIn() async {
    try {
      _googleSignIn.disconnect();
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    Size size = sizeMH(context);
    return Container(
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images_lt/login-1.png'),
            fit: BoxFit.cover),
      ),
      // margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.vertical,
        child: Column(children: [
          // Image.network(
          //     fit: BoxFit.cover,
          //     height: size.height * 0.4,
          //     "https://3.bp.blogspot.com/-y9kpCo82zjI/VearjMoMZrI/AAAAAAAAGlI/h9VNIuwtkSY/s1600/tai-hinh-nen-may-tinh-dep-nhung-dam-may-hinh-trai-tim-tren-bau-troi-467856.jpg"),
          addVertical(size: size.height * 0.2),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text("Đăng nhập", style: textTheme(context).headline4),
          ),
          addVertical(size: 10),
          Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Tài khoản"),
                onChanged: (a) {
                  username = a;
                },
              ),
              addVertical(size: 10),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(hintText: "Mật khẩu"),
                onChanged: (a) {
                  password = a;
                },
              )
            ],
          ),
          addVertical(size: 20),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                child: Text(
                  "Quên mật khẩu?",
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  ontapChuyenMH(ResetPasswordPage(), context);
                }),
          ),
          addVertical(size: 20),
          Container(
              // margin: EdgeInsets.symmetric(horizontal: 20),
              width: size.height * 0.5, // <-- match_parent
              // height: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    if (await checkStatus()) {
                      if (await loginAccount(username, password)) {
                        Map a = (await loginToken(usernameUserCurrentToken));
                        getOneUser(a['_id'], 'account').then((value) {
                          var json = jsonDecode(value);
                          currentUserF = User(
                              idUser: json['_id'],
                              name: json['name'],
                              imageUrl: (json['avtURL'] != null)
                                  ? json['avtURL']
                                  : avarUrlNull,
                              email:
                                  (json['email'] != null) ? json['email'] : "0",
                              idAcc: json['account']);
                          // print(currentUserF.idUser);
                          if (currentUserF != null) {
                            ontapChuyenMH(MyApp(), context);
                          }
                        });
                      }
                    } else {
                      toast("Bạn chưa kết nối internet", Colors.red);
                    }
                  },
                  child: Text("Đăng nhập"))),
          addVertical(size: 10),
          Text("Hoặc"),
          addVertical(size: 10),
          ElevatedButton.icon(
            onPressed: _handleSignIn,
            icon: Icon(Icons.g_mobiledata),
            label: Text("Đăng nhập với Google"),
          ),
          addVertical(size: 10),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
                text: "Bạn đã có tài khoản?",
                style: TextStyle(color: Colors.black)),
            WidgetSpan(
                child: InkWell(
              onTap: () => ontapChuyenMH(const RegisterWidget(), context),
              child: Text('Đăng ký', style: TextStyle(color: Colors.blue)),
            ))
          ]))
        ]),
      ),
    );
  }

  Future<void> getToken(Widget widget, BuildContext context) async {
    List<Map> tokens = await NotesDatabase.instance.readAllNotes();
    final String token = tokens.first['token'].toString();

    if (token.isNotEmpty) {
      // print();
      Map a = (await loginToken(token));
      getOneUser(a['_id'], 'account').then((value) {
        var json = jsonDecode(value);
        currentUserF = User(
            idUser: json['_id'],
            name: json['name'],
            imageUrl: (json['avtURL'] != null) ? json['avtURL'] : avarUrlNull,
            email: (json['email'] != null) ? json['email'] : 0,
            idAcc: json['account']);
        // print(currentUserF.idUser);
        if (currentUserF != null) {
          ontapChuyenMH(MyApp(), context);
        }
      });

      // print();
    }
  }
}

Future<Map<String, dynamic>> loginToken(token) async {
  final response = await http.post(
    Uri.parse('http://' + IP + '/account/login'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
    },
  );
  final responseJson = jsonDecode(response.body);

  return responseJson;
}

Future<bool> loginAccount(username, password) async {
  final response = await http.post(Uri.parse('http://' + IP + '/account/login'),
      // Send authorization headers to the backend.
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}));

  if (response.statusCode == 400) {
    toast("Tài khoản hoặc mật khẩu không chính xác", Colors.red);
    return false;
    // return responseJson;
  }
  Map<String, dynamic> responseJson = json.decode(response.body);
  usernameUserCurrentToken = responseJson['token'];
  await NotesDatabase.instance.delete();
  await NotesDatabase.instance.create(responseJson['token']);
  return true;
}
