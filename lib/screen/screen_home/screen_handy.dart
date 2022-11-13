import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/material.dart';

import '../../custom_widget.dart';

class MenuHandy extends StatelessWidget {
  const MenuHandy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Handy(
            text: "Thước phim",
            ic: Icons.video_camera_back,
            color: Color.fromARGB(255, 241, 88, 77)),
        Handy(
            text: "Trạng thái",
            ic: Icons.tag_faces_outlined,
            color: Colors.orange),
        Handy(text: "Nhóm", ic: Icons.group, color: Colors.blue),
        Handy(text: "Phát trực tiếp", ic: Icons.live_tv, color: Colors.red),
      ],
    );
  }
}

class Handy extends StatelessWidget {
  const Handy({
    Key? key,
    this.colorBack,
    required this.text,
    required this.ic,
    required this.color,
    this.size,
  }) : super(key: key);
  final String text;
  final IconData ic;
  final double? size;
  final Color color;
  final colorBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          color: colorBack ?? Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: RichText(
            text: TextSpan(children: [
          WidgetSpan(
              child: Icon(
            color: color,
            size: size ?? 20,
            ic,
          )),
          WidgetSpan(child: const addHorial(size: 10)),
          TextSpan(text: text,style: textTheme(context).bodyText1),
        ])),
      ),
    );
  }
}
