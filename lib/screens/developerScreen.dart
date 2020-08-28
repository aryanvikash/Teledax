import 'package:Teledax/style/constants.dart';
import 'package:Teledax/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Dev extends StatefulWidget {
  @override
  _DevState createState() => _DevState();
}

class _DevState extends State<Dev> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Text(
                    "About",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _aryaninfo(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _odinfo(),
          ),
        ],
      )),
    );
  }
}

Widget _aryaninfo() {
  return Card(
    color: darkCardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 20,
    child: ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
                "https://avatars3.githubusercontent.com/u/31583400"),
          ),
        ),
      ),
      title: Text(
        "Aryan Vikash",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 50, top: 5),
        child: Text(
          "App Developer",
          style: TextStyle(color: Colors.white),
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
              await launchurl("https://github.com/aryanvikash");
            },
          ),
          IconButton(
            icon: Icon(MdiIcons.telegram, color: Colors.blueAccent),
            onPressed: () async {
              await launchurl("https://telegram.me/aryanvikash");
            },
          )
        ],
      ),
    ),
  );
}

Widget _odinfo() {
  return Card(
    color: darkCardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 20,
    child: ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(
                "https://avatars1.githubusercontent.com/u/35767464"),
          ),
        ),
      ),
      title: Text(
        "Christy Roys",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 50, top: 5),
        child: Text(
          "Thanks For Beautiful Api ❤️",
          style: TextStyle(color: Colors.white),
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
              await launchurl("https://github.com/odysseusmax");
            },
          ),
          IconButton(
            icon: Icon(MdiIcons.telegram, color: Colors.blueAccent),
            onPressed: () async {
              await launchurl("https://telegram.me/odysseusmax");
            },
          )
        ],
      ),
    ),
  );
}
