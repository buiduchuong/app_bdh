import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:flutter/material.dart';

import 'bottom_navi_chung/bottom_navigation.dart';
import 'message/home_mess.dart';
import 'screen/screen_home/body.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Body(),
          appBar: MyAppBar(context),
          bottomNavigationBar: BottoNavigationBarFB(),
        ));
  }

  AppBar MyAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      title: Text(
        "BDH",
        style: Theme.of(context).textTheme.headline4?.apply(color: Colors.blue),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 220, 220),
              shape: BoxShape.circle),
          child: IconButton(
            // focusColor: Color.fromARGB(255, 207, 36, 36),
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 222, 220, 220),
              shape: BoxShape.circle),
          child: IconButton(
            // focusColor: Color.fromARGB(255, 207, 36, 36),
            onPressed: () {
              // print("AAAAAAAAAAxxxxx");
              ontapChuyenMH(MyWidgetMessage(), context);
            },
            icon: Icon(
              Icons.message,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
