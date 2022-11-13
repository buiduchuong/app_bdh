// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:design_flutter_ui_4/models/user_models.dart';

class Story {
  final int id;
  final User user;
  final String imageUrl;
  late bool isViewed;
  Story( {
   required this.id,
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}
