import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import 'data/data.dart';
import 'models/post_models.dart';
import 'models/user_models.dart';

class addVertical extends StatelessWidget {
  final double size;

  const addVertical({Key? key, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}

class addHorial extends StatelessWidget {
  final double size;

  const addHorial({Key? key, required this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size);
  }
}

void ontapChuyenMH(Widget widget, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (a) {
    return widget;
  }));
}

Future<void> toast(String message, Color color) async {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      textColor: Colors.black54,
      backgroundColor: color,
      fontSize: 16.0);
}

Upload(File imageFile) async {
  var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();

  var uri = Uri.parse("http://$IP/upload/post");

  var request = new http.MultipartRequest("POST", uri);
  var multipartFile = new http.MultipartFile('image', stream, length,
      filename: basename(imageFile.path));
  //contentType: new MediaType('image', 'png'));

  request.files.add(multipartFile);
  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}

void back(BuildContext context) {
  Navigator.pop(context);
}

Future<String> getOneUser(String idAccount, String a) async {
  // User user;
  var url = Uri.parse('http://' + IP + '/user/getOne');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        a: idAccount,
      }));
  // final user = jsonDecode(response.body);

  // print();
  return response.body;
}

Future<User> getOneUserID(String id) async {
  // User user;
  var url = Uri.parse('http://' + IP + '/user/getUserByID');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
      }));
  // print(" sadsdsd"+response.body);
  final json = jsonDecode(response.body);
  final user = User.fromJson(json);
  return user;
}

Future addPost(String caption, String imgUrl) async {
  var url = Uri.parse('http://' + IP + '/post/add');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': currentUserF.idUser,
        'caption': caption,
        'imageUrl': imgUrl,
        'nameUser': currentUserF.name,
        'urlUser': currentUserF.imageUrl,
      }));

  return response.statusCode;
}

Future updatePost(String caption, String imgUrl) async {
  var url = Uri.parse('http://' + IP + '/post/add');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user': idUserCurrent,
        'caption': caption,
        'imageUrl': imgUrl
      }));

  return response.statusCode;
}

Future<List> getAllPost() async {
  var url = Uri.parse('http://' + IP + '/post/getAll');
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  var ar = json.decode(response.body);
  return ar;
}

String convertDatetimeToString(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd :: HH:mm');
  final String formatted = formatter.format(date);
  // print(formatted);
  return formatted;
}

Future updateUser(String urlAvt, String email, String name) async {
  var url = Uri.parse('http://' + IP + '/user/update');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        '_id': currentUserF.idUser,
        'avtURL': (urlAvt != "") ? urlIMG + urlAvt : currentUserF.imageUrl,
        'name': name,
        'email': email,
      }));

  return response.statusCode;
}

Container circularProgress() {
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.purple),
      ));
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}

Future<bool> checkStatus() async {
  // ConnectivityResult result = await _connectivity.checkConnectivity();
  bool isOnline = false;
  try {
    final result = await InternetAddress.lookup('example.com');
    isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    isOnline = false;
  }
  return isOnline;
}

Future<int> getUserEmail(String email) async {
  var url = Uri.parse('http://' + IP + '/user/getUserEmail');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }));

  return response.statusCode;
}

Future updateAccount(String id, String pass) async {
  var url = Uri.parse('http://' + IP + '/account/updatePass');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'password': pass.trim(),
      }));
  if (response.statusCode == 200) {
    toast("Thay đổi mật khẩu thành công!", Colors.green);
  }
  return response.statusCode;
}

Future<List> getPostToUser(id) async {
  var url = Uri.parse('http://' + IP + '/post/getPostToUser');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
      }));
  var ar = json.decode(response.body);

  return ar;
}
