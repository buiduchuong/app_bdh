import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/material.dart';

class NameFB extends StatelessWidget {
  const NameFB({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: name,
          style: textTheme(context).headline4?.apply(color: Colors.black)),
      const WidgetSpan(
          child: Icon(
        Icons.check_circle_rounded,
        size: 20,
        color: Colors.blue,
      ))
    ]));
  }
}
