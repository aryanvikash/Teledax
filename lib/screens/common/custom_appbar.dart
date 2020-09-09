import 'package:Teledax/style/constants.dart';
import 'package:flutter/material.dart';

AppBar customAppbar(appbarText, context) {
  return AppBar(
    actions: [
      IconButton(
        icon: Icon(
          Icons.settings,
          color: accents,
        ),
        onPressed: () => Navigator.of(context).pushNamed("/setting"),
      )
    ],
    backgroundColor: lightColor,
    elevation: 0,
    centerTitle: true,
    title: Text(
      appbarText,
      style: TextStyle(color: fontColor),
    ),
  );
}
