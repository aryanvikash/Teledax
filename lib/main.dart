import 'package:Teledax/screens/developerScreen.dart';
import 'package:Teledax/screens/home/home.dart';
import 'package:Teledax/screens/listfiles/listfilesScreen.dart';
import 'package:Teledax/screens/singleitem/file_info.dart';
import 'package:Teledax/style/constants.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          accentColor: accents,
          primaryColor: accents,
          canvasColor: Colors.transparent),
      debugShowCheckedModeBanner: false,
      title: "TeleDax",
      // home: MyHome(),
      initialRoute: "/",
      routes: {
        "/": (_) => MyHome(),
        "/files": (_) => FilesScreen(),
        "/fileinfo": (_) => FIleInfo(),
        "/devs": (_) => Dev(),
      },
    );
  }
}
