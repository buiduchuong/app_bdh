import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';
import 'wiget_custom/rich_text_custom.dart';

class ButtonCustomProfile extends StatelessWidget {
  const ButtonCustomProfile({
    Key? key,
    required this.idUser,
  }) : super(key: key);
  final String idUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: ButtonCustom(
            name: "Đang theo dõi",
            color: Color.fromARGB(255, 218, 217, 217),
            icon: Icons.subscriptions,
          ),
        ),
        addHorial(size: 10),
        const Expanded(
          child: ButtonCustom(
            name: "Nhắn tin",
            color: Colors.blue,
            icon: Icons.message,
          ),
        ),
        addHorial(size: 10),
        ButtonCustom(
          ontap: () {
            if (idUser == currentUserF.idUser) {
              ontapChuyenMH(EditProfile(), context);
            }
          },
          name: "",
          color: Color.fromARGB(255, 218, 217, 217),
          icon: Icons.more_horiz,
          colorIc: Colors.black,
        ),
      ],
    );
  }
}

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    required this.icon,
    this.colorIc,
    required this.name,
    required this.color,
    this.ontap,
  }) : super(key: key);
  final IconData icon;
  final String name;
  final Color color;
  final colorIc;
  final ontap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.all(10),

          // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        ),
        onPressed: ontap,
        child: RichtextCustom(icon: icon, colorIc: colorIc, name: name));
  }
}
