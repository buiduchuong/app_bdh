import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'article.dart';
import '../../custom_widget.dart';
import 'header_cap.dart';
import 'screen_handy.dart';
import 'story_widget.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSocketio();
    _connectSocket();
  }

  _connectSocket() {
    socket1.onConnect((data) => print('connected established'));
    socket1.onConnectError((data) => print('connect error: ' + data));
    // _socket.on('message1', (data) {
    //   consumer.setState((state) {
    //     setState(() {
    //       state.addNewMessage(Message.fromJson(data));
    //     });
    //   });
    // });

    socket1.onDisconnect((data) => print('Socket.IO server disconnected'));
  }

  _initSocketio() {
   
    socket1 = IO.io(
        'http://$IP:80',
        IO.OptionBuilder().setTransports(['websocket']).setQuery(
            {'username': currentUserF.name}).build());
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              HeaderWidgetCap(
                user: currentUserF,
                size: size,
              ),
              const addVertical(size: 10),
              const SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: MenuHandy()),
              const addVertical(size: 10)
            ],
          ),
          const Divider(height: 10, thickness: 7),
          const ScrollViewStori(),
          const Divider(height: 10, thickness: 7),
          FutureBuilder<List>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Post> postss =
                      snapshot.data!.map((e) => Post.fromJson(e)).toList();
                  return Column(
                    children: postss
                        .map((e) => ArticleWidgets(
                              post: e,
                             
                            ))
                        .toList(),
                  );
                }
                return Container();
              },
              future: getAllPost())
          // Column(
          //   children: posts.map((e) => ArticleWidgets(post: e)).toList(),
          // )
        ],
      ),
    );
  }
}
