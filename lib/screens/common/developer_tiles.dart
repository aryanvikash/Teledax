import 'package:Teledax/style/constants.dart';
import 'package:Teledax/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

developerTile(
    {@required name,
    @required githubUsername,
    @required profileImage,
    @required telegramUsername,
    @required devtype}) {
  return ListTile(
    leading: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(profileImage),
        ),
      ),
    ),
    title: Text(
      name,
      style: TextStyle(
        fontSize: 20,
        color: fontColor,
      ),
      textAlign: TextAlign.center,
    ),
    subtitle: Padding(
      padding: const EdgeInsets.only(left: 50, top: 5),
      child: Text(
        devtype,
        style: TextStyle(color: fontColor),
      ),
    ),
    trailing: Wrap(
      direction: Axis.horizontal,
      children: [
        IconButton(
          icon: Icon(
            MdiIcons.github,
          ),
          onPressed: () async {
            await launchurl("https://github.com/${githubUsername}");
          },
        ),
        IconButton(
          icon: Icon(MdiIcons.telegram, color: Colors.blueAccent),
          onPressed: () async {
            await launchurl("https://telegram.me/${telegramUsername}");
          },
        )
      ],
    ),
  );
}
