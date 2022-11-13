import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/models/user_models.dart';
import 'package:design_flutter_ui_4/partnner_custom.dart';
import 'package:design_flutter_ui_4/screen/screen_home/article.dart';
import 'package:design_flutter_ui_4/custom_widget.dart';

import 'package:design_flutter_ui_4/screen/screen_profile/widget_button.dart';
import 'package:design_flutter_ui_4/screen/screen_profile/wiget_custom/rich_text_custom.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'avt_bia.dart';
import 'button_custom.dart';
import 'name_fb.dart';
import 'story_profile.dart';

class BodyProfile extends StatefulWidget {
  final User user;
  const BodyProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  @override
  Widget build(BuildContext context) {
    String name = widget.user.name;
    String imgAvt = widget.user.imageUrl;
    String truongH = widget.user.truongHoc;
    String quanHe = widget.user.quanHe;
    String songTai = widget.user.songTai;
    int follows = widget.user.follows;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header_avt_bia(
              size: size,
              imgURL: imgAvt,
              idUser: widget.user.idUser,
            ),

            addVertical(size: size.height * 0.15),
            Center(child: NameFB(name: name)),
            const addVertical(size: 20),
            ButtonCustomProfile(
              idUser: widget.user.idUser,
            ),
            const addVertical(size: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                truongH.isNotEmpty
                    ? RichtextCustom(
                        icon: Icons.school,
                        name: "Từng học $truongH \n",
                        colorIc: Colors.grey[500],
                      )
                    : Container(),
                songTai.isNotEmpty
                    ? RichtextCustom(
                        icon: Icons.home,
                        name: "Sống tại $songTai\n",
                        colorIc: Colors.grey[500],
                      )
                    : Container(),
                quanHe.isNotEmpty
                    ? RichtextCustom(
                        icon: Icons.favorite,
                        name: "$quanHe\n",
                        colorIc: Colors.grey[500],
                      )
                    : Container(),
                follows != 0
                    ? RichtextCustom(
                        icon: Icons.rss_feed,
                        name: "Có $follows người theo dõi\n",
                        colorIc: Colors.grey[500],
                      )
                    : Container(),
                RichtextCustom(
                  icon: Icons.more_horiz,
                  name: "Xem thông tin giới thiệu của $name\n",
                  colorIc: Colors.grey[500],
                ),
              ],
            ),
            // const StoryProfile(),
            const Divider(height: 14, thickness: 1),
            Text(
              "Bạn bè",
              style: textTheme(context).headline5?.apply(color: Colors.black),
            ),
            const Divider(height: 14, thickness: 1),
            Text(
              "Bài viết",
              style: textTheme(context).headline5?.apply(color: Colors.black),
            ),
            addVertical(size: 5),
            const WidgetButton(),
              addVertical(size: 10),
            FutureBuilder<List>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Post> postss =
                      snapshot.data!.map((e) => Post.fromJson(e)).toList();
                  return Column(
                    children: postss
                        .map((e) => ArticleWidgets(
                              post: e,
                            ))
                        .toList(),
                  );
                }
                return Container();
              },
              future: getPostToUser(widget.user.idUser),
            )
          ],
        ),
      ),
    );
  }
}
