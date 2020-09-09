import 'package:Teledax/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    _checkApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _checkApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DatabaseHelper db = DatabaseHelper.instance;
    var apiId = prefs.getInt("defaultapi");

    if (apiId != null) {
      var idResult = await db.getById(id: apiId);

      if (idResult != null && idResult.length > 0) {
        Navigator.of(context).popAndPushNamed("/chatids",
            arguments: {"baseurl": idResult[0]['url']});
      } else {
        print(prefs.getKeys());
        Navigator.of(context).popAndPushNamed("/addapi");
      }
    } else {
      prefs.clear();
      print(prefs.getKeys());
      Navigator.of(context).popAndPushNamed("/addapi");
    }
  }
}
