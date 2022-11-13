import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/screen/screen_home/screen_handy.dart';
import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Handy(
            text: "Ảnh",
            ic: Icons.photo_library,
            size: 17,
            color: Colors.black,
            colorBack: Color.fromARGB(255, 227, 226, 226)),
        addHorial(size: 10),
        Handy(
            text: "Sự kiện trong đời",
            size: 20,
            ic: Icons.star_half,
            colorBack: Color.fromARGB(255, 227, 226, 226),
            color: Colors.black),
      ],
    );
  }
}
