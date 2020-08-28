import 'package:flutter/material.dart';

Widget autoIconSelector(mime) {
  if (mime.contains("audio")) {
    return Icon(
      Icons.music_note,
      color: Colors.green,
      size: 40,
    );
  } else if (mime.contains("video")) {
    return Icon(
      Icons.ondemand_video,
      color: Colors.blue,
      size: 40,
    );
  } else if (mime.contains("image")) {
    return Icon(
      Icons.image,
      color: Colors.orangeAccent,
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
  }
  return Icon(
    Icons.insert_drive_file,
    color: Colors.redAccent,
    size: 40,
  );
}
