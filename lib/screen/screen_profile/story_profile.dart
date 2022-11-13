import 'package:design_flutter_ui_4/screen/screen_home/story_widget.dart';
import 'package:flutter/material.dart';

class StoryProfile extends StatelessWidget {
  const StoryProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        StoryWidget(
          name: "+1",
          image: "assets/images_lt/avtar.PNG",
          width: 60,
          heigh: 100,
        ),
        StoryWidget(
          name: "+1",
          image: "assets/images_lt/avtar.PNG",
          width: 60,
          heigh: 100,
        ),
      ],
    );
  }
}
