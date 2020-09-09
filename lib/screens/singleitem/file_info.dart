import 'package:Teledax/player/audioPlayer.dart';
import 'package:Teledax/screens/common/reuseable_items.dart';
import 'package:Teledax/style/constants.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FIleInfo extends StatefulWidget {
  @override
  _FIleInfoState createState() => _FIleInfoState();
}

class _FIleInfoState extends State<FIleInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var item;
  var data;
  var baseurl;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    item = data['item'];
    baseurl = data["baseurl"];

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: lightColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 100 * 25,
              child: urlImageLoader(data, item),
            ),
            SingleChildScrollView(
              child: Card(
                child: ListTile(
                  title: Text(
                    "${item.insight}",
                    style: TextStyle(
                        color: fontColor,
                        fontSize:
                            MediaQuery.of(context).size.height / 100 * 2.7,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          "${item.size}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: fontColor, fontSize: 15),
                        ),
                      ),
                      buildDivider(),
                      ListTile(
                        title: Text(
                          " ${item.mimeType}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: fontColor, fontSize: 15),
                        ),
                      ),
                      buildDivider(),
                      ListTile(
                        title: Text(
                          "${DateFormat('hh:mm:a - dd-MM-yy').format(item.date)}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: fontColor, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showAutoIntent(
              url: "$baseurl/${data['chatid']}/${item.fileId}/download",
              mimeType: item.mimeType,
            );
          },
          backgroundColor: SecondaryColor,
          child: Icon(
            MdiIcons.openInApp,
            color: Colors.white,
          ),
          elevation: 20,
        ),
        bottomNavigationBar: _autoplayer(item),
      ),
    );
  }

  Widget _autoplayer(item) {
    if (item.mimeType.contains("video")) {
      return _bottomPlayButton();
    } else if (item.mimeType.contains("audio")) {
      return PlayerWidget(
          url: "$baseurl/${data['chatid']}/${item.fileId}/download");
    }
    return null;
  }

  Widget urlImageLoader(data, item) {
    return Image.network(
      "$baseurl/${data['chatid']}/${item.fileId}/thumbnail",
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        print(error);
        return Image.asset(
          "images/not-found.png",
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }

  // Bottom Button
  Widget _bottomPlayButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 100 * 8,
        child: FlatButton.icon(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          onPressed: () {
            Navigator.of(context).pushNamed("/videoplayer", arguments: {
              "item": item,
              "baseurl": baseurl,
              "chatid": data['chatid'],
            });
          },
          icon: Icon(
            MdiIcons.play,
            color: Colors.white,
            size: 40,
          ),
          label: Text(
            "Play",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          splashColor: accents,
          color: accents,
        ),
      ),
    );
  }
}
