import 'package:Teledax/screens/common/developer_tiles.dart';
import 'package:Teledax/style/constants.dart';
import 'package:Teledax/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info/package_info.dart';

import 'common/reuseable_items.dart';

class Dev extends StatefulWidget {
  @override
  _DevState createState() => _DevState();
}

class _DevState extends State<Dev> {
  var version;
  var buildNumber;

  setversion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    setState(() {});
  }

  @override
  void initState() {
    setversion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Center(
                      child: Text(
                        "About",
                        style: TextStyle(color: fontColor, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset("images/logo.png"),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "TeleDax",
                  style: TextStyle(color: fontColor, fontSize: 30),
                ),
              ),
              SizedBox(height: 20),
              _devsinfo()
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Version ${version} || Build ${buildNumber}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

Widget _devsinfo() {
  return Card(
    elevation: 1,
    color: cardLightColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      children: [
        developerTile(
            name: "Aryan vikash",
            githubUsername: "aryanvikash",
            profileImage: "https://avatars3.githubusercontent.com/u/31583400",
            telegramUsername: "aryanvikash",
            devtype: "App Developer"),
        SizedBox(
          height: 10,
        ),
        buildDivider(),
        developerTile(
            name: "Christy Roys",
            githubUsername: "odysseusmax",
            profileImage: "https://avatars1.githubusercontent.com/u/35767464",
            telegramUsername: "odysseusmax",
            devtype: "Api Developer"),
      ],
    ),
  );
}
