// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_flutter_ui_4/database/database.dart';
import 'package:design_flutter_ui_4/main.dart';
import 'package:flutter/material.dart';

import 'package:design_flutter_ui_4/custom_widget.dart';

import '../partnner_custom.dart';
import 'login.dart';


class ChangePassword extends StatelessWidget {
  final String idAcc;
  const ChangePassword({
    Key? key,
    required this.idAcc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 50,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Thay đổi mật khẩu",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nhập vào mật khẩu và xác nhận mật khẩu",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Mật khẩu",
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordConfirmController,
                        decoration: InputDecoration(
                          labelText: "Xác nhận mật khẩu",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3, 1],
                            colors: [
                              Color(0xFFF58524),
                              Color(0XFFF92B7F),
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: SizedBox.expand(
                          child: ElevatedButton(
                            child: Text(
                              "Gửi",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () async {
                              if (passwordController.text ==
                                  passwordConfirmController.text) {
                                await updateAccount(
                                    idAcc,
                                    passwordController.text
                                        .toLowerCase()
                                        .trim());
                                await NotesDatabase.instance.delete();
                                ontapChuyenMH(LoginWidget(), context);
                              } else {
                                toast(
                                    "Mật khẩu và xác nhận mật khẩu phải giống nhau!",
                                    Colors.red);
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
