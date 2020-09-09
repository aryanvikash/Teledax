import 'package:Teledax/screens/addApi/add_apis.dart';
import 'package:Teledax/screens/chatids/list_chatids.dart';
import 'package:Teledax/screens/developerScreen.dart';
import 'package:Teledax/screens/listfiles/listfilesScreen.dart';
import 'package:Teledax/screens/settings/setting_screen.dart';
import 'package:Teledax/screens/singleitem/file_info.dart';
import 'package:Teledax/screens/videoPlayer/video_player.dart';
import 'package:Teledax/spalash.dart';
import 'package:Teledax/style/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: accents,
          primaryColor: accents,
          canvasColor: Colors.white),
      debugShowCheckedModeBanner: false,
      title: "TeleDax",
      initialRoute: "/",
      routes: {
        "/": (_) => SplashScreen(),
        "/addapi": (_) => AddApi(),
        "/chatids": (_) => ChatIds(),
        "/files": (_) => FilesScreen(),
        "/fileinfo": (_) => FIleInfo(),
        "/devs": (_) => Dev(),
        "/videoplayer": (_) => VideoPlyerScreen(),
        "/setting": (_) => Settings(),
      },
    );
  }
}
