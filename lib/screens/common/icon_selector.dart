import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget autoIconSelector(mime) {
  if (mime.contains("audio")) {
    return Icon(
      Icons.music_note,
      color: Colors.greenAccent,
      size: 40,
    );
  } else if (mime.contains("video")) {
    return Icon(
      Icons.ondemand_video,
      color: Colors.deepPurple,
      size: 40,
    );
  } else if (mime.contains("image")) {
    return Icon(
      Icons.image,
      color: Colors.deepOrangeAccent,
      size: 40,
    );
  } else if (mime.contains("android")) {
    return Icon(
      Icons.android,
      color: Colors.green,
      size: 40,
    );
  } else if (mime.contains("pdf")) {
    return Icon(
      Icons.picture_as_pdf,
      color: Colors.red,
      size: 40,
    );
  } else if (mime.contains("sticker")) {
    return Icon(
      MdiIcons.stickerEmoji,
      color: Colors.pink,
      size: 40,
    );
  } else if (mime.contains("zip")) {
    return Icon(
      MdiIcons.zipBox,
      color: Colors.blueAccent,
      size: 40,
    );
  }
  return Icon(
    Icons.insert_drive_file,
    color: Color(0xffFF2525),
    size: 40,
  );
}
