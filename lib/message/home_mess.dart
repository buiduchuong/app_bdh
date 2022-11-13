// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/home.dart';
import 'package:design_flutter_ui_4/maudung/avatar.dart';
import 'package:design_flutter_ui_4/models/models.dart';
import 'package:design_flutter_ui_4/my_flutter_app_icons.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'chat.dart';

class MyWidgetMessage extends StatefulWidget {
  const MyWidgetMessage({Key? key}) : super(key: key);

  @override
  State<MyWidgetMessage> createState() => _MyWidgetMessageState();
}

class _MyWidgetMessageState extends State<MyWidgetMessage> {
  late final IO.Socket _socket;
  late Future<List<User>> listFuture;
  late Future<List<Message>> listMessFuture;
  _initSocketio() {
    _socket = IO.io(
        'http://$IP:3000',
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'username': currentUserF.name}).build());
  }

  _connectSocket() {
    _socket.onConnect((data) => print('connected established'));
    _socket.onConnectError((data) => print('connect error: ' + data));
    // _socket.on('message1', (data) {
    //   consumer.setState((state) {
    //     setState(() {
    //       state.addNewMessage(Message.fromJson(data));
    //     });
    //   });
    // });

    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  }

  Future<List<User>> getAllUser() async {
    var url = Uri.parse('http://' + IP + ':80/user/');
    var response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    Iterable json = jsonDecode(response.body);
    // List<Comment> mapComment =
    //   List<Comment>.from(json.map((model) => Comment.fromJson(model)));

    List<User> listUser = List<User>.from(json.map((e) => User.fromJson(e)));

    // print(listUser.toString() + "chay khong");
    return listUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSocketio();
    _connectSocket();
    listFuture = getAllUser();
    listMessFuture = getUserChat();
  }

  Future<List<Message>> getUserChat() async {
    var url = Uri.parse('http://' + IP + ':3000/getUserChat');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': currentUserF.idUser,
        }));
    Iterable json = jsonDecode(response.body);
    // print(json);
    //  List<User> listUser = List<User>.from(json.map((e) => User.fromJson(e)));
    List<Message> messages =
        List<Message>.from(json.map((e) => Message.fromJson(e)));
    // print(messages.length);

    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 30,
        backgroundColor: Colors.white,
        title: Center(
          child: Row(
            children: [
              Text(
                "Đoạn chat",
                style: textTheme(context).headline6,
              ),
            ],
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
           ontapChuyenMH(MyApp(), context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          Container(
            height: 60,
            width: 60,
        
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            decoration: BoxDecoration(
                // color: Color.fromARGB(255, 222, 220, 220),
                shape: BoxShape.circle),
            child: AvtarTron(size: 30, url: currentUserF.imageUrl),
          ),
          addHorial(size: 20)
         
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                addVertical(size: 5),
                Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: 40,
                  child: TextField(
                      // expands: false,
                      cursorColor: Colors.grey[70],
                      clipBehavior: Clip.none,
                      // selectionControls: ,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color.fromARGB(255, 235, 232, 232),

                        filled: true,
                        // prefixIconColor: Colors.white70,
                        // focusColor: Colors.white70,h

                        iconColor: Colors.grey[70],
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 235, 232, 232),
                                width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Tìm kiếm",
                        prefixIcon: Icon(Icons.search),
                      )),
                ),
                addVertical(size: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 235, 232, 232)),
                            child: const Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.video_call),
                            ),
                          ),
                          addVertical(size: 5),
                          const Text("Tạo phòng\n họp mặt")
                        ],
                      ),
                      FutureBuilder<List<User>>(
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<User> users = snapshot.data!;
                              return Row(
                                children: users
                                    .map((e) =>
                                        (e.idUser != currentUserF.idUser)
                                            ? AnhvatenBB(
                                                user: e, socket: this._socket)
                                            : Container())
                                    .toList(),
                              );
                            }
                            return Container();
                          },
                          future: listFuture),
                      // Row(
                      //   children: onlineUsers
                      //       .map((e) => AnhvatenBB(
                      //             url: e.imageUrl,
                      //             name: e.name,
                      //           ))
                      //       .toList(),
                      // ),
                    ],
                  ),
                ),
                addVertical(size: 10),
                FutureBuilder<List<Message>>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Message> messages = snapshot.data!;

                      return Column(
                        children: messages
                            .map((e) => TinNhanToi(
                                socket: this._socket,
                                tinnhan: e.content,
                                userID: e.idUser))
                            .toList(),
                      );
                    }
                    return Container();
                  },
                  future: listMessFuture,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.comment), label: "Đoạn chat"),
            BottomNavigationBarItem(
                icon: Icon(Icons.videocam), label: "Cuộc gọi"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "Danh bạ"),
            BottomNavigationBarItem(
                icon: Icon(Icons.switch_video), label: "Tin"),
          ]),
    );
  }
}

class TinNhanToi extends StatelessWidget {
  const TinNhanToi({
    Key? key,
    required this.tinnhan,
    required this.userID,
    required this.socket,
  }) : super(key: key);
  final String tinnhan;

  final String userID;

  final IO.Socket socket;

  @override
  Widget build(BuildContext context) {
    User? user;
    return InkWell(
      onTap: () async {
        await createRoom(currentUserF.idUser, userID).then((value) {
          var id = json.decode(value);

          ontapChuyenMH(
              ChatWigets(
                idRoom: id['id'],
                user: user!,
                socket: socket,
              ),
              context);
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FutureBuilder<User>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = snapshot.data!;
                return Row(
                  children: [
                    AvtarTron(size: 50, url: user!.imageUrl),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.name,
                            style: textTheme(context).titleMedium,
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: tinnhan,
                                style: textTheme(context).bodySmall),
                            const WidgetSpan(child: addHorial(size: 10)),
                            // TextSpan(
                            //     text: "thoiGianNhan",
                            //     style: textTheme(context).bodySmall)
                          ]))
                        ],
                      ),
                    )
                  ],
                );
              }
              return Container();
            },
            future: getOneUserID(userID)),
      ),
    );
  }
}

class AnhvatenBB extends StatelessWidget {
  const AnhvatenBB({
    Key? key,
    required this.user,
    required this.socket,
  }) : super(key: key);
  final User user;
  final IO.Socket socket;
  @override
  Widget build(BuildContext context) {
    List<String> arrName = user.name.split(" ");
    return InkWell(
      onTap: () async {
        await createRoom(currentUserF.idUser, user.idUser).then((value) {
          var id = json.decode(value);

          ontapChuyenMH(
              ChatWigets(
                idRoom: id['id'],
                user: user,
                socket: socket,
              ),
              context);
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AvtarTron(size: 50, url: user.imageUrl),
            addVertical(size: 5),
            Center(
                child: Text(
                    "${arrName[0]} \n ${arrName.length > 1 ? arrName[1] + "..." : " "}"))
          ],
        ),
      ),
    );
  }
}

Future createRoom(String id1, String id2) async {
  var url = Uri.parse('http://$IP:3000/create');
  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id1': id1,
        'id2': id2,
      }));

  return response.body;
}
