import 'package:design_flutter_ui_4/custom_widget.dart';

import 'models.dart';

class Comment {
  final String id;
  final String postId;
  final String content;
  final String idUserComment;
  final String name;
  final String urlAvt;
  Comment(this.name, this.urlAvt,
      {required this.content,
      required this.idUserComment,
      required this.postId,
      required this.id});

  // ignore: empty_constructor_bodies
  Comment.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        postId = json['postId'],
        content = json['content'],
        idUserComment = json['idUserComment'],
        name = json['name'],
        urlAvt = json['urlAvt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'content': content,
        'idUserComment': idUserComment,
        'name': name,
        'urlAvt': urlAvt
      };
}
