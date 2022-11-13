import 'dart:convert';

import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/models/post_models.dart';
import 'package:http/http.dart' as http;
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:design_flutter_ui_4/screen/comment/main.dart';
import 'package:design_flutter_ui_4/screen/screen_profile/main_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../custom_widget.dart';
import '../../models/models.dart';

class ArticleWidgets extends StatefulWidget {
  const ArticleWidgets({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;
  @override
  State<ArticleWidgets> createState() => _ArticleWidgetsState();
}

class _ArticleWidgetsState extends State<ArticleWidgets> {
  late bool tf_Showmore = widget.post.caption.length > 100;
  // bool trueFalse = false;
  int stateCode = 201;
  late int likes = widget.post.likes;
  void _pressShowMore() {
    setState(() {
      tf_Showmore = !tf_Showmore;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLike();
    on();
  }

  Future addPostLike() async {
    var url = Uri.parse('http://' + IP + '/post/like');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': widget.post.idPost,
          'idUserLike': currentUserF.idUser,
        }));
    setState(() {
      stateCode = response.statusCode;
    });
    return response.statusCode;
  }

  Future<int> checkLike() async {
    var url = Uri.parse('http://' + IP + '/post/checkLike');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': widget.post.idPost,
          'idUserLike': currentUserF.idUser,
        }));
    setState(() {
      stateCode = response.statusCode;
    });
    return response.statusCode;
  }

  on() {
    socket1.on('message1', (data) {
      if (mounted) {
        setState(() {
          if (data['like'] != null) {
            if (data['idPost'] == widget.post.idPost) {
              likes = int.parse(data['like']);
            }

            print(data['like']);
          }
        });
      }
    });
  }

  void _pressLike() async {
    // String like = "like";

    addPostLike();

    setState(() {
      stateCode == 201 ? likes++ : likes--;
      // like = stateCode == 201 ? "ok" : "no";
      _sendMessage(likes);
    });
  }

  _sendMessage(int like) {
    socket1.emit('message', {
      "like": likes.toString(),
      "idPost": widget.post.idPost,
    });
  }

  void _pressComment() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User user = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            (await checkStatus())
                                ? getOneUserID(widget.post.user).then((value) {
                                    ontapChuyenMH(
                                        MyAppProfile(user: value), context);
                                  })
                                : toast("Bạn chưa bật internet", Colors.red);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.network(
                              user.imageUrl,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                        addHorial(size: 10),
                        InkWell(
                          onTap: () async {
                            (await checkStatus())
                                ? getOneUserID(widget.post.user).then((value) {
                                    ontapChuyenMH(
                                        MyAppProfile(user: value), context);
                                  })
                                : toast("Bạn chưa mở internet", Colors.red);
                          },
                          child: Text(user.name,
                              style: Theme.of(context).textTheme.headline6),
                        ),
                      ],
                    ),
                    Row(
                      children: [Icon(Icons.more_horiz), Icon(Icons.close)],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: (tf_Showmore
                          ? widget.post.caption.substring(0, 100)
                          : widget.post.caption),
                      style: textTheme(context).bodyText2),
                  if (tf_Showmore)
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = _pressShowMore,
                        text: "...show more",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.apply(color: Colors.grey))
                ])),
              ),
              !widget.post.imageUrl.isEmpty
                  ? Image.network(
                      widget.post.imageUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(),
              addVertical(size: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                        WidgetSpan(
                            child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blue),
                          child: const Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        )),
                        TextSpan(
                            text: " ${likes}",
                            style: textTheme(context).bodyText1)
                      ])),
                    ),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: widget.post.comments.toString(),
                          style: textTheme(context).bodyText1),
                      TextSpan(
                          text: " comment", style: textTheme(context).bodyText1)
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: " ${widget.post.shares}",
                          style: textTheme(context).bodyText1),
                      TextSpan(
                          text: " share", style: textTheme(context).bodyText1)
                    ]))
                  ],
                ),
              ),
              const Padding(
                padding: const EdgeInsets.all(5.0),
                child: Divider(
                  height: 8,
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WigetsCmtLikeShare(
                    ontap: () async {
                      (await checkStatus())
                          ? _pressLike()
                          : toast("Bạn chưa mở internet", Colors.red);
                    },
                    color: stateCode == 200 ? Colors.blue : Colors.black,
                    text: "Like",
                    icon: stateCode == 200
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined,
                  ),
                  WigetsCmtLikeShare(
                      ontap: () async {
                        // await findCommentPostID().then((value) => mapComment = value);

                        // if (mapComment != null) {
                        //   getOneUserID(widget.post.user).then((value) {
                        ontapChuyenMH(
                            MyComment(
                              post: widget.post,
                            ),
                            context);
                        // } ); }
                      },
                      color: Colors.black,
                      text: "Comment",
                      icon: Icons.mode_comment_outlined),
                  WigetsCmtLikeShare(
                    color: Colors.black,
                    text: "Share",
                    icon: Icons.share_outlined,
                  ),
                ],
              ),
              const Divider(height: 20, thickness: 7),
            ],
          );
        }
        return Container();
      },
      future: getOneUserID(widget.post.user),
    );
  }

  void clickLike(bool trueFalse) {
    setState(() {
      (trueFalse = !trueFalse) ? widget.post.likes + 1 : widget.post.likes - 1;
      print("sao ma la vay: $trueFalse");
    });
  }
}

class WigetsCmtLikeShare extends StatelessWidget {
  const WigetsCmtLikeShare({
    this.ontap,
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final GestureTapCallback? ontap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: RichText(
          text: TextSpan(children: [
        WidgetSpan(
            child: Icon(
          icon,
          color: color,
          // size: 10,
        )),
        TextSpan(text: " $text", style: textTheme(context).subtitle1)
      ])),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String a = "a";

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
