// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_flutter_ui_4/custom_widget.dart';

import '../data/data.dart';
import 'user_models.dart';

class Post {
  final int id;
  final String idPost;
  final String user;
  final String urlUser;
  final String nameUser;
  final String caption;
  final String imageUrl;
  final int likes;
  final int timeAgo;
  final int comments;
  final int shares;
  Post({
    required this.urlUser,
    required this.id,
    this.idPost = "",
    required this.nameUser,
    required this.user,
    this.timeAgo = 0,
    required this.caption,
    this.imageUrl = "",
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });
  Post.fromJson(Map<String, dynamic> json)
      : idPost = json['_id'],
        id = 0,
        user = json['user'],
        urlUser = json['urlUser'],
        nameUser = json['nameUser'],
        timeAgo = DateTime.now().millisecondsSinceEpoch,
        caption = json['caption'],
        imageUrl = (json['imageUrl'] != null) && (json['imageUrl'] != "")
            ? "http://$IP/images/" + json['imageUrl']
            : "",
        likes = json['likes'].length,
        comments = (json['comments'] != null) ? json['comments'] : 0,
        shares = 0;

  Map<String, dynamic> toJson() => {
        'likes': likes,
      };
}
