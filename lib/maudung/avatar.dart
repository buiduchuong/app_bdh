import 'package:flutter/material.dart';

class AvtarTron extends StatelessWidget {
  const AvtarTron({
    Key? key,
    required this.size,
    required this.url,
  }) : super(key: key);
  final double size;
  final String url;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(90),
        child: SizedBox(
            width: size,
            height: size,
            child: Image.network(fit: BoxFit.cover, url)));
  }
}