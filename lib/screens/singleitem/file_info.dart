import 'package:Teledax/api/Api.dart';
import 'package:Teledax/player/audioPlayer.dart';
import 'package:Teledax/player/videoplayer.dart';
import 'package:Teledax/style/constants.dart';
import 'package:Teledax/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:video_player/video_player.dart';

class FIleInfo extends StatefulWidget {
  @override
  _FIleInfoState createState() => _FIleInfoState();
}

class _FIleInfoState extends State<FIleInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var item;
  var data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    item = data['item'];

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: darkcolor,
        body: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 60,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: urlImageLoader(data, item),
            ),
            Container(
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 15,
                children: [
                  Text(
                    "${item.insight}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "size: ${item.size}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    item.mimeType,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: _autoplayer(item.mimeType, item),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await launchurl(
              "$baseurl/${data['chatid']}/${item.fileId}/download"),
          backgroundColor: Colors.white,
          child: Icon(
            MdiIcons.download,
            color: accents,
          ),
          elevation: 20,
        ),
      ),
    );
  }

  Widget _autoplayer(mimeType, item) {
    if (mimeType.contains("video")) {
      return MyCustomVideoPlayer(
        videoPlayerController: VideoPlayerController.network(
            "$baseurl/${data['chatid']}/${item.fileId}/download"),
      );
    } else if (mimeType.contains("audio")) {
      return PlayerWidget(
          url: "$baseurl/${data['chatid']}/${item.fileId}/download");
    }
    return null;
  }
}

// Image loader func from url( with download progress bar)
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
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
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
