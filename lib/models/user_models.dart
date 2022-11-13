// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_flutter_ui_4/data/data.dart';

class User {
  final int id;
  final String name;
  final String imageUrl;
  final String idUser;
  final String truongHoc;
  final String songTai, quanHe;
  final int follows;
  final String email;
  final String idAcc;

  User({
    this.idAcc = "",
    this.email = "",
    this.idUser = "",
    this.id = 0,
    this.follows = 0,
    this.songTai = "",
    this.quanHe = "",
    this.truongHoc = "",
    required this.name,
    this.imageUrl = "http://$IP/images/img-fb.jpg",
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        idAcc = json['account'],
        id = 0,
        follows = 0,
        email = (json['email'] != null) ? json['email'] : "0",
        songTai = "",
        quanHe = "",
        truongHoc = "",
        imageUrl = (json['avtURL'] != null)
            ? json['avtURL']
            : "http://$IP/images/img-fb.jpg",
        idUser = json['_id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'avtURL': imageUrl,
      };
}
