import 'dart:io';

import 'package:Teledax/util/utils.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';

Container buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 50.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade400,
  );
}

showAutoIntent({@required url, @required mimeType}) async {
  if (Platform.isAndroid && mimeType.contains("video")) {
    AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      type: 'video/*',
      data: url,
    );
    try {
      await intent.launch();
    } catch (e) {
      print(e);
    }
  } else if (Platform.isAndroid && mimeType.contains("audio")) {
    AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      type: 'audio/*',
      data: url,
    );
    try {
      await intent.launch();
    } catch (e) {
      print(e);
    }
  } else {
    await launchurl(url);
  }
}
