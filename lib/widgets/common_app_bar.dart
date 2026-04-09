import 'package:flutter/material.dart';
import '../utilities/color_utility.dart';
import '../utilities/style_utility.dart';

PreferredSizeWidget commonAppBar({
  required String title,
  bool showBack = true,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: ColorUtility.colorEA580C,
  //  backgroundColor: Colors.white,
    elevation: 2,
    centerTitle: false,
    leading: showBack
        ? BackButton(color: Colors.white)
        : null,
    title: Text(
      title,
      style: StyleUtility.appBarTextStyle,
    ),
    actions: actions,
  );
}