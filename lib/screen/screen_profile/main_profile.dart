import 'package:design_flutter_ui_4/bottom_navi_chung/bottom_navigation.dart';
import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/home.dart';
import 'package:design_flutter_ui_4/models/user_models.dart';
import 'package:flutter/material.dart';

import 'body_profile.dart';

class MyAppProfile extends StatelessWidget {
  const MyAppProfile({Key? key, required this.user}) : super(key: key);

  final User user;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottoNavigationBarFB(),
      body: BodyProfile(
        user: user,
      ),
      appBar: MyAppBar(context),
    );
  }

  AppBar MyAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      // shadowColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          back(context);
        },
        icon: Icon(Icons.arrow_back),
        color: Colors.black,
      ),
      title: Center(
        child: InkWell(
          onTap: (){
            ontapChuyenMH(MyApp(), context);
          },
          child: Text(
            user.name,
            style:
                Theme.of(context).textTheme.subtitle1?.apply(color: Colors.black),
          ),
        ),
      ),
      actions: const [
        Icon(
          Icons.search,
          color: Colors.black,
        ),
      ],
    );
  }
}
