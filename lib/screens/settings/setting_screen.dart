import 'package:Teledax/screens/common/reuseable_items.dart';
import 'package:Teledax/style/constants.dart';
import 'package:Teledax/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _audioPlayback;
  var _videoPlayback;
  final TextStyle headerStyle = TextStyle(
    color: Colors.grey.shade800,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );
  setInitSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _audioPlayback = prefs.getBool('audioplayback') ?? false;
    _videoPlayback = prefs.getBool('videoplayback') ?? false;

    setState(() {});
  }

  @override
  void initState() {
    setInitSettings();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "settings",
            style: TextStyle(color: fontColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Player", style: headerStyle),
              SizedBox(
                height: 10,
              ),
              _player(),
              SizedBox(
                height: 18,
              ),
              Text(
                "Additional",
                style: headerStyle,
              ),
              SizedBox(
                height: 10,
              ),
              _additional(),
              SizedBox(
                height: 18,
              ),
              Text(
                "info",
                style: headerStyle,
              ),
              SizedBox(
                height: 10,
              ),
              info(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Made in India ❤️", textAlign: TextAlign.center),
        ),
      ),
    );
  }

  // player catagory
  _player() {
    return Card(
      color: cardLightColor,
      child: Column(
        children: [
          ListTile(
            title: Text("Audio play In background"),
            trailing: Switch(
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.redAccent,
              activeColor: Colors.green,
              activeTrackColor: Colors.greenAccent,
              value: _audioPlayback ?? false,
              onChanged: (value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('audioplayback', !_audioPlayback);
                _audioPlayback = prefs.getBool("audioplayback");
                setState(() {});
              },
            ),
          ),
          buildDivider(),
          // ++++  Video Play in background+++++++
          ListTile(
            title: Text("Video play In Background"),
            trailing: Switch(
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.redAccent,
              activeColor: Colors.green,
              activeTrackColor: Colors.greenAccent,
              value: _videoPlayback ?? false,
              onChanged: (value) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('videoplayback', !_videoPlayback);
                _videoPlayback = prefs.getBool("videoplayback");

                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  // info catagory
  info() {
    return Card(
      color: cardLightColor,
      child: Column(
        children: [
          ListTile(
            onTap: () => launchurl("https://t.me/teledax"),
            title: Text("Support Group"),
            trailing: Icon(
              MdiIcons.telegram,
              color: Colors.blue,
            ),
          ),
          buildDivider(),
          ListTile(
            onTap: () => Navigator.of(context).pushNamed("/devs"),
            title: Text("About"),
            trailing: Icon(
              MdiIcons.information,
              color: SecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _additional() {
    return Card(
      color: cardLightColor,
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.of(context).pushNamed("/addapi"),
            title: Text("Manage Api"),
            trailing: Icon(
              MdiIcons.plus,
              color: accents,
            ),
          ),
        ],
      ),
    );
  }
}
