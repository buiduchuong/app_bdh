import 'package:design_flutter_ui_4/data/data.dart';

class Message {
  final String idUser;
  final String content;
  Message({
    required this.idUser,
    required this.content,
  });
  Message.fromJson(Map<String, dynamic> json)
      : this.idUser = (json['user2'] == currentUserF.idUser)
            ? json['user1']
            : json['user2'],
        this.content = json['messages'].length > 0
            ? json['messages'].last['content']
            : "Bạn chưa nhắn tin với người này";
}
