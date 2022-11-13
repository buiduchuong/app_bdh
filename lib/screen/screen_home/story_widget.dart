import 'package:design_flutter_ui_4/data/data.dart';
import 'package:design_flutter_ui_4/models/models.dart';
import 'package:design_flutter_ui_4/custom_widget.dart';
import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    Key? key,
    required this.image,
    required this.name,
    this.clipImage,
    required this.width,
    required this.heigh,
  }) : super(key: key);
  final clipImage;
  final String image;
  final String name;
  final double width;

  final double heigh;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          BackImage(image: image, width: width, heigh: heigh),
          clipImage ?? Container(),
          Positioned(
              bottom: 5,
              left: 10,
              right: 10,
              child: Text(name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.apply(color: Colors.white)))
        ],
      ),
    );
  }
}

class CicleImage extends StatelessWidget {
  const CicleImage({
    Key? key,
    required this.imageSto,
  }) : super(key: key);

  final String imageSto;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            border: Border.all(width: 5, color: Colors.blue)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            imageSto,
            fit: BoxFit.fill,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}

class BackImage extends StatelessWidget {
  const BackImage({
    Key? key,
    required this.image,
    required this.width,
    required this.heigh,
  }) : super(key: key);

  final String image;
  final double width;
  final double heigh;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        image,
        width: width,
        height: heigh,
        fit: BoxFit.cover,
      ),
    );
  }
}

class FirtsStory extends StatelessWidget {
  final User user;
  const FirtsStory({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackImage(image: user.imageUrl, width: 120, heigh: 200),
      Positioned(
        child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 5),
                color: Colors.white,
                shape: BoxShape.circle),
            child: const Icon(
              Icons.add,
              color: Colors.blue,
            )),
      )
    ]);
  }
}

class ScrollViewStori extends StatelessWidget {
  const ScrollViewStori({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FirtsStory(
            user: currentUser,
          ),
          addHorial(size: 5),
          Row(
            children: stories
                .map((e) => StoryWidget(
                    image: e.imageUrl,
                    name: e.user.name,
                    clipImage: CicleImage(imageSto: e.user.imageUrl),
                    width: 120,
                    heigh: 200))
                .toList(),
          ),
        ],
      ),
    );
  }
}
