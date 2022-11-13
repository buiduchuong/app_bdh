import 'dart:convert';

import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/maudung/avatar.dart';
import 'package:design_flutter_ui_4/models/user_models.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

import '../models/models.dart';
import 'home_mess.dart';
// void main() => runApp(MaterialApp(
//       title: "App",
//       home: ChatWigets(
//         user: currentUser,
//       ),
//     ));

class ChatWigets extends StatefulWidget {
  const ChatWigets(
      {Key? key,
      required this.user,
      required this.socket,
      required this.idRoom})
      : super(key: key);
  final User user;
  final IO.Socket socket;
  final String idRoom;

  @override
  State<ChatWigets> createState() => _ChatWigetsState();
}

class _ChatWigetsState extends State<ChatWigets> {
  late Future<List> chatsFuture;
  late List chats = [];
  initRoom() {
    widget.socket.emit('message', {
      'idRoom': widget.idRoom,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatsFuture = getChat();
    initRoom();
    on();
  }

  @override
  void dispose() {
    super.dispose();
  }

  on() {
    this.widget.socket.on('message1', (data) {
      if (mounted) {
        setState(() {
          if (data['content'] != null) {
            chats.add(data);
          }
        });
      }
    });
  }

  //  print(chats[0]['sender']);

  Future<List> getChat() async {
    var url = Uri.parse('http://$IP:3000/get');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': this.widget.idRoom,
        }));
    List chats = json.decode(response.body);
    // print(chats[0]['sender']);
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        themeMode: ThemeMode.light,
        home: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    minimum: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: FutureBuilder<List>(
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              chats = snapshot.data!;
                              return Container(
                                
                                child: Column(
                                  children: chats
                                      .map((e) => e['sender'] ==
                                              currentUserF.name
                                          ? BodyChatIsGUI(label: e['content'])
                                          : BodyChat(label: e['content']))
                                      .toList(),
                                ),
                              );
                            }
                            return Container();
                          },
                          future: chatsFuture,
                        )

                        // Column(
                        //   children: chats
                        //       .map((e) => e['sender'] == currentUserF.idUser
                        //           ? BodyChatIsGUI(label: e['content'])
                        //           : BodyChat(label: e['content']))
                        //       .toList(),
                        // ),
                        ),
                  ),
                ),
                NhapTinNhan(
                  user: widget.user,
                  idRoom: widget.idRoom,
                  socket: widget.socket,
                )
              ],
            ),
            appBar: AppBar(
              title: Row(children: [
                AvtarTron(
                  size: 30,
                  url: widget.user.imageUrl,
                ),
                addHorial(size: 14),
                Text(
                  widget.user.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )
              ]),
              iconTheme: Theme.of(context).iconTheme,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 54,
              leading: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                           ontapChuyenMH(MyWidgetMessage(), context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                    ),
                  )),
            )));
  }
}

class NhapTinNhan extends StatefulWidget {
  const NhapTinNhan({
    Key? key,
    required this.socket,
    required this.idRoom,
    required this.user,
  }) : super(key: key);
  final IO.Socket socket;
  final User user;
  final String idRoom;
// late List chats;
  @override
  State<NhapTinNhan> createState() => _NhapTinNhanState();
}

class _NhapTinNhanState extends State<NhapTinNhan> {
  TextEditingController controller = new TextEditingController();
  _sendMessage() {
    widget.socket.emit('message', {
      'idRoom': widget.idRoom,
      'sender': currentUserF.name,
      'receiver': widget.user.name,
      'content': controller.text,
      'sentAt': new DateTime.now().microsecondsSinceEpoch.toString()
    });
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final Size size = sizeMH(context);
    return SizedBox(
      height: size.width * 0.1,
      child: SafeArea(
          top: false,
          bottom: true,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 2, color: Theme.of(context).dividerColor))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: size.width * 0.1 * 0.3),
                  child: Icon(
                    Icons.camera_alt,
                    size: size.width * 0.1 * 0.7,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: size.width * 0.1 * 0.3),
                      child: TextField(
                        controller: controller,
                        style: TextStyle(fontSize: size.width * 0.2 * 0.2),
                        decoration: InputDecoration(
                            hintText: "Aa", border: InputBorder.none),
                      ))),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 10),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    child: Icon(
                      Icons.send,
                      size: size.width * 0.1 * 0.7,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _sendMessage();
                      {}
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class BodyChatIsGUI extends StatelessWidget {
  const BodyChatIsGUI({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    final Size size = sizeMH(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Colors.blue),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.1 * 0.3,
                horizontal: size.width * 0.1 * 0.3),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: size.width * 0.2 * 0.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}

class BodyChat extends StatelessWidget {
  const BodyChat({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    final Size size = sizeMH(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              color: Colors.grey[100]),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.1 * 0.3,
                horizontal: size.width * 0.1 * 0.3),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: size.width * 0.2 * 0.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}
