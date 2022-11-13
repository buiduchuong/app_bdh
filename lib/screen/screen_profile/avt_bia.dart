import 'dart:convert';
import 'dart:io';

import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/models.dart';
import 'edit_profile.dart';
import 'main_profile.dart';

class Header_avt_bia extends StatelessWidget {
  const Header_avt_bia({
    Key? key,
    required this.size,
    required this.imgURL,
    required this.idUser,
  }) : super(key: key);

  final Size size;
  final String imgURL;
  final String idUser;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          child: Image.network(
            imgURL,
            width: size.width,
            height: size.height * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          // width: 500,
          bottom: -size.height * 0.13,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 5,
                  color: Colors.white,
                )),
            child: InkWell(
              onTap: () {
                // toast("message");
                if (idUser == currentUserF.idUser) {
                  ontapChuyenMH(EditProfile(), context);
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  fit: BoxFit.cover,
                  imgURL, width: size.width / 3,
                  height: size.width / 3,
                  // height: size.height * 0.4,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
