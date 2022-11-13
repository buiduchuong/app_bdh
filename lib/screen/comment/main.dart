import 'dart:convert';

import 'package:design_flutter_ui_4/bottom_navi_chung/bottom_navigation.dart';
import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/maudung/avatar.dart';
import 'package:design_flutter_ui_4/models/comment_models.dart';
import 'package:design_flutter_ui_4/models/models.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:design_flutter_ui_4/screen/screen_home/article.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../home.dart';
import '../screen_profile/main_profile.dart';

class MyComment extends StatefulWidget {
  const MyComment({Key? key, required this.post}) : super(key: key);
  // final User user;
  final Post post;
  @override
  State<MyComment> createState() => _MyCommentState();
}

class _MyCommentState extends State<MyComment> {
  late Future<List<Comment>> cmtFuture;
  final _conTrollerEditText = TextEditingController();
  List<Comment> mapComment = [];
  late String soCmt;
  Future<int> addComment() async {
    var url = Uri.parse('http://' + IP + '/comment/add');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'postId': this.widget.post.idPost,
          'idUserComment': currentUserF.idUser,
          'content': _conTrollerEditText.text,
          'name': currentUserF.name,
          'urlAvt': currentUserF.imageUrl
        }));

    return response.statusCode;
  }

  Future updateCmtPost() async {
    var url = Uri.parse('http://' + IP + '/post/comments');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': widget.post.idPost,
          'cmt': soCmt,
        }));

    return response.statusCode;
  }

  Future<List<Comment>> findCommentPostID(String id) async {
    var url = Uri.parse('http://' + IP + '/comment/findCmtPostId');
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          // 'postId': this.widget.post.idPost,
          'postId': id,
        }));
    Iterable json = jsonDecode(response.body);
    print(json);
    List<Comment> mapComment =
        List<Comment>.from(json.map((model) => Comment.fromJson(model)));
    // print(mapComment.first.toJson());
    return mapComment;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cmtFuture = findCommentPostID(widget.post.idPost);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: App_Bar(context),
        body: FutureBuilder<List<Comment>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                mapComment = snapshot.data!;
                return BodyComment(
                  widget: widget,
                  comments: mapComment,
                );
              }
              return Container();
            },
            future: cmtFuture),
        bottomNavigationBar: Container(
            color: Colors.white,
            height: 110,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 40,
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromARGB(255, 220, 220, 220)),
                          width: 350,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                                hintMaxLines: 10,
                                contentPadding: EdgeInsets.only(left: 20),
                                focusedBorder: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 220, 220, 220),
                                        width: 1)),
                                hintText: "Comment",
                                labelStyle:
                                    textTheme(context).apply().bodySmall),
                            controller: _conTrollerEditText,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            await addComment();

                            // await findCommentPostID(widget.post.idPost)
                            //     .then((value) => mapComment = value);

                            setState(() {
                              //                     'postId': this.widget.post.idPost,
                              // 'idUserComment': currentUserF.idUser,
                              // 'content': _conTrollerEditText.text,
                              // 'name': currentUserF.name,
                              // 'urlAvt': currentUserF.imageUrl
                              mapComment.add(Comment(
                                  currentUserF.name, currentUserF.imageUrl,
                                  content: _conTrollerEditText.text,
                                  idUserComment: currentUserF.idUser,
                                  postId: this.widget.post.idPost,
                                  id: "0"));
                              soCmt = mapComment.length.toString();
                              _conTrollerEditText.text = "";
                            });
                            await updateCmtPost();

                            // print(_conTrollerEditText.text + " hihi");
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  BottoNavigationBarFB()
                ],
              ),
            )),
      ),
    );
  }

// new InkWell( // to dismiss the keyboard when the user tabs out of the TextField
  AppBar App_Bar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      // shadowColor: Colors.white
      leading: IconButton(
        onPressed: () {
          back(context);
        },
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
      ),
      title: Center(
        child: Container(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  getOneUserID(widget.post.user).then((value) {
                    ontapChuyenMH(MyAppProfile(user: value), context);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.network(
                    widget.post.urlUser,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              addHorial(size: 10),
              InkWell(
                onTap: () {
                  getOneUserID(widget.post.user).then((value) {
                    ontapChuyenMH(MyAppProfile(user: value), context);
                  });
                },
                child: Text(widget.post.nameUser,
                    style: Theme.of(context).textTheme.headline6),
              ),
            ],
          ),
        ),
      ),
      actions: const [
        Icon(
          Icons.more_horiz_rounded,
          color: Colors.black,
        ),
      ],
    );
  }
}

class BodyComment extends StatefulWidget {
  BodyComment({Key? key, required this.widget, required this.comments})
      : super(key: key);

  final MyComment widget;
  late List<Comment> comments;

  @override
  State<BodyComment> createState() => _BodyCommentState();
}

class _BodyCommentState extends State<BodyComment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // findCommentPostID();
    // mapComment.forEach((element) => {print(element + "hhihihii")});

    return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          // reverse: true,
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ArticleWidgets(
                post: widget.widget.post,
                ),
              Column(
                children:
                    widget.comments.map((e) => CommentWidget(cmt: e)).toList(),
              )
            ],
          ),
        ));
  }
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({Key? key, required this.cmt}) : super(key: key);
  final Comment cmt;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    // print("keke");

    return Column(
      children: [
        Row(
          children: [
            AvtarTron(size: 30, url: this.widget.cmt.urlAvt),
            addHorial(size: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.widget.cmt.name,
                        style: textTheme(context).headline6,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: widget.cmt.content,
                            style: textTheme(context).bodyText1),
                        const WidgetSpan(child: addHorial(size: 10)),
                      ]))
                    ],
                  ),
                ),
              ),
            ),
            addHorial(size: 10)
          ],
        ),
        addVertical(size: 10)
      ],
    );
  }
}
