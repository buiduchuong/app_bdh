import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/database/database.dart';
import 'package:design_flutter_ui_4/login_register/login.dart';
import 'package:design_flutter_ui_4/main.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../custom_widget.dart';
import '../../models/models.dart';
import 'main_profile.dart';

class EditProfile extends StatefulWidget {
  // final String currentUserId;
  // late String idUser;
  // EditProfile();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool isLoading = false;
  File? imageFile = null;
  // late User user = currentUserF;

  @override
  void initState() {
    super.initState();
    getUser();
    // urlToFile();
    userNameController.text = currentUserF.name.trim();
    emailController.text = currentUserF.email.trim();
  }

  // Future<File> urlToFile() async {
  //   final http.Response responseData = await http.get(Uri.parse(
  //       (currentUserF.imageUrl != null)
  //           ? currentUserF.imageUrl
  //           : "http://$IP/images/img-fb.jpg"));
  //   final uint8list = responseData.bodyBytes;
  //   var buffer = uint8list.buffer;
  //   ByteData byteData = ByteData.view(buffer);
  //   var tempDir = await getTemporaryDirectory();
  //   File file = await File('${tempDir.path}/img').writeAsBytes(
  //       buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //       print(file.toString()+"hihihi");
  //   imageFile = file;
  //   return file;
  // }

  _onTapCapNhatAvt(BuildContext context) async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image == null) return;
    // print(image.path);
    final imageTemporary = File(image.path);
    if (imageTemporary != null) {
      setState(() {
        imageFile = imageTemporary;
      });
    }

    // await getOneUser(currentUserF.idUser).then((value) {
    //   var json1 = json.decode(value);
    //   print("kakkskakakak " + json1);
    //   User user = User(
    //     idUser: json1['_id'],
    //     name: json1['name'],
    //     imageUrl: (json1['avtURL'] != null) ? json1['avtURL'] : avarUrlNull,
    //   );
    //   // toast("kakakakakka");
    //   ontapChuyenMH(
    //       MyAppProfile(
    //         user: user,
    //       ),
    //       context);
    // });
    return imageTemporary;
  }

  getUser() async {
    setState(() {
      isLoading = false;
    });

    setState(() {
      isLoading = false;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: userNameController,
          decoration: InputDecoration(
            labelText: "Họ và tên",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
          ),
        )
      ],
    );
  }

  Future<dynamic> myBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (context) {
        return SizedBox(
          height: sizeMH(context).height * 0.4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const addVertical(size: 15),
                const widgetInBottomSheet(
                    icon: Icons.person_pin, text: "Xem ảnh đại diện"),
                widgetInBottomSheet(
                  icon: Icons.photo_library,
                  text: "Chọn ảnh đại diện",
                  ontap: () {
                    _onTapCapNhatAvt(context);
                  },
                ),
                const widgetInBottomSheet(
                    icon: Icons.picture_in_picture, text: "Thêm khung"),
                const widgetInBottomSheet(
                    icon: Icons.face_retouching_natural_rounded,
                    text: "Dùng Avatar làm ảnh đại diện"),
              ],
            ),
          ),
        );
      },
    );
  }

  Column passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          controller: passwordController,
          decoration: InputDecoration(
            labelText: "Mật khẩu",
          ),
        ),
        TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          controller: passwordConfirmController,
          decoration: InputDecoration(
            labelText: "Xác nhận mật khẩu",
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chỉnh sửa trang cá nhân",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                ontapChuyenMH(MyAppProfile(user: currentUserF), context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 5,
                                color: Colors.white,
                              )),
                          child: GestureDetector(
                            onTap: () {
                              // toast("message");
                              // if (this.widget.idUser == currentUserF.idUser) {
                              myBottomSheet(context);
                              // }
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: (imageFile != null)
                                    ? Image.file(
                                        fit: BoxFit.cover,

                                        imageFile!,

                                        width: sizeMH(context).width / 3,
                                        height: sizeMH(context).width / 3,
                                        // height: size.height * 0.4,
                                      )
                                    : Image.network(
                                        fit: BoxFit.cover,

                                        currentUserF.imageUrl,

                                        width: sizeMH(context).width / 3,
                                        height: sizeMH(context).width / 3,
                                        // height: size.height * 0.4,
                                      )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            buildDisplayNameField(),
                            buildBioField(),
                            passwordField()
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[200]),
                        onPressed: () async {
                          if (imageFile != null) {
                            await Upload(imageFile!);
                          }
                          // print(imageFile!.path.split('/').last + "hihihihhi");
                          await updateUser(
                            (imageFile != null)
                                ? imageFile!.path.split('/').last
                                : "",
                            emailController.text,
                            userNameController.text,
                          );
                          // print(emailController.text);
                          // print(currentUserF.idAcc);
                          if (passwordController.text != "" &&
                              passwordController.text.isNotEmpty &&
                              passwordConfirmController.text != "" &&
                              passwordConfirmController.text.isNotEmpty) {
                            if (passwordController.text ==
                                passwordConfirmController.text) {
                              await updateAccount(currentUserF.idAcc,
                                  passwordController.text.toLowerCase().trim());
                            } else {
                              toast(
                                  "Mật khẩu và xác nhận mật khẩu phải giống nhau!",
                                  Colors.red);
                            }
                          } else {
                            toast(
                                "Mật khẩu và xác nhận mật khẩu không được để rỗng!",
                                Colors.red);
                          }
                          getOneUser(currentUserF.idAcc, 'account')
                              .then((value) {
                            var json = jsonDecode(value);
                            setState(() {
                              currentUserF = User(
                                  idUser: json['_id'],
                                  name: json['name'],
                                  imageUrl: (json['avtURL'] != null)
                                      ? json['avtURL']
                                      : avarUrlNull,
                                  email: (json['email'] != null)
                                      ? json['email']
                                      : "0",
                                  idAcc: json['account']);
                              // print("chay cai nay");
                            });
                          });
                          toast("Cập nhật trang cá nhân thành công",
                              Colors.green);
                        },
                        child: Text(
                          "Cập nhật trang cá nhân",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await NotesDatabase.instance.delete();
                            ontapChuyenMH(LoginWidget(), context);
                          },
                          icon: Icon(Icons.cancel, color: Colors.red),
                          label: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class widgetInBottomSheet extends StatelessWidget {
  const widgetInBottomSheet({
    this.ontap,
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final GestureTapCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, top: 5),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 222, 220, 220),
                  shape: BoxShape.circle),
              child: IconButton(
                // focusColor: Color.fromARGB(255, 207, 36, 36),
                onPressed: () {
                  // print("AAAAAAAAAAxxxxx");
                  // ontapChuyenMH(MyWidgetMessage(), context);
                },
                icon: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
            ),
            Text(" $text",
                style: textTheme(context).headline6?.apply(color: Colors.black))
          ],
        ));
  }
}
