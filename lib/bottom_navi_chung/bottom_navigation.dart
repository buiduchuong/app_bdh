import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/home.dart';
import 'package:flutter/material.dart';

class BottoNavigationBarFB extends StatefulWidget {
  const BottoNavigationBarFB({
    Key? key,
  }) : super(key: key);

  @override
  State<BottoNavigationBarFB> createState() => _BottoNavigationBarFBState();
}

class _BottoNavigationBarFBState extends State<BottoNavigationBarFB> {
  @override
  Widget build(BuildContext context) {
    int _index = 0;
    return BottomNavigationBar(
      currentIndex: _index,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
        BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video), label: "Watch"),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: "Marketplace"),
        BottomNavigationBarItem(
            icon: Icon(Icons.dvr_rounded), label: "Bảng feed"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications), label: "Thông báo"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
      ],
      onTap: (index) {
        setState(() {
          _index = index;
          ontapChuyenMH(MyApp(), context);
        });
      },
    );
  }
}
