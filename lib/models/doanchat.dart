// ignore_for_file: public_member_api_docs, sort_constructors_first

class Inbox {
  final String id;
  final String sender;
  final String receiver;
  final String content;
  final int sentAt;
  Inbox({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.sentAt,
  });
  Inbox.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        sender = json['sender'],
        receiver = json['receiver'],
        content = json['content'],
        sentAt = json['sentAt'];

  Map<String, dynamic> toJson() => {
        'content': content,
        'sender': sender,
      };
}
