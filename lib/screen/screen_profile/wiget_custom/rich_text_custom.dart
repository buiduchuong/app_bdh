import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/material.dart';

class RichtextCustom extends StatelessWidget {
  const RichtextCustom({
    Key? key,
    required this.icon,
    required this.colorIc,
    required this.name,
  }) : super(key: key);

  final IconData icon;
  final colorIc;
  final String name;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      WidgetSpan(
          child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Icon(
          icon,
          size: 20,
          color: colorIc,
        ),
      )),
      TextSpan(
          text: name,
          style: textTheme(context).bodyText1?.apply(color: Colors.black))
    ]));
  }
}
