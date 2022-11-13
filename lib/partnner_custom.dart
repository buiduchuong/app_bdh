import 'package:flutter/material.dart';

TextTheme textTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

Size sizeMH(BuildContext context) {
  return MediaQuery.of(context).size;
}
