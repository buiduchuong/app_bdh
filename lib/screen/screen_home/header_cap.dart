import 'dart:async';
import 'dart:io';

import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/home.dart';
import 'package:design_flutter_ui_4/models/models.dart';
import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:design_flutter_ui_4/screen/screen_profile/main_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;

class HeaderWidgetCap extends StatefulWidget {
  final User user;
  const HeaderWidgetCap({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);
  final Size size;
  @override
  State<HeaderWidgetCap> createState() => _HeaderWidgetCapState();
}

class _HeaderWidgetCapState extends State<HeaderWidgetCap> {
  double _heigh = 50;
  bool trueFals = false;
  File? _image;
  Timer? _timer;
  TextEditingController _controller = TextEditingController();
  int _start = 30;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _start = 30;
            trueFals = false;
            _heigh = 50;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Future getImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return;
    // print(image.path);
    final imageTemporary = File(image.path);
    setState(() {
      this._image = imageTemporary;
    });
    return imageTemporary;
  }

  changeHeighPost() {
    setState(() {
      _heigh = 200;
      trueFals = true;
      startTimer();
    });
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: InkWell(
              onTap: () async {
                (await checkStatus())
                    ? ontapChuyenMH(MyAppProfile(user: widget.user), context)
                    : toast("message", Colors.red);
              },
              child: Image.network(
                widget.user.imageUrl,
                width: 50,
                scale: 1.0,
                fit: BoxFit.fill,
                height: 50,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(
                    color: (trueFals) ? Colors.grey : Colors.white,
                    width: 1.5,
                  ),
                ),
                padding: const EdgeInsets.only(left: 20),
                height: _heigh,
                width: widget.size.width * 0.8,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onTap: changeHeighPost,
                  decoration: InputDecoration(
                      hintText: "Bạn đang nghĩ gì?",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      icon: InkWell(
                        onTap: getImage,
                        child: const Icon(
                          Icons.photo,
                          color: Colors.green,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () async {
                          await addPost(
                              _controller.text,
                              (_image != null)
                                  ? _image!.path.split('/').last
                                  : "");
                          if (_image != null) {
                            await Upload(_image!);
                          }
                          setState(() {
                            this._image = null;
                            _controller.text = "";
                          });
                          ontapChuyenMH(MyApp(), context);
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.green,
                        ),
                      )),
                ),
              ),
              (this._image != null)
                  ? Container(
                      height: 100,
                      width: 100,
                      child: Stack(children: <Widget>[
                        Image.file(
                          this._image!,
                          height: 100,
                          width: 100,
                        ),
                        Positioned(
                            top: -1,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  this._image = null;
                                });
                              },
                              child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(90)),
                                  child: const Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'x',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  )),
                            )),
                      ]),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
