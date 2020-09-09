import 'package:Teledax/player/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlyerScreen extends StatefulWidget {
  @override
  _VideoPlyerScreenState createState() => _VideoPlyerScreenState();
}

class _VideoPlyerScreenState extends State<VideoPlyerScreen> {
  var baseurl;

  var item;

  var _data;

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;
    baseurl = _data["baseurl"];
    item = _data["item"];
    return Container(
      child: MyCustomVideoPlayer(
        videoPlayerController: VideoPlayerController.network(
            "$baseurl/${_data['chatid']}/${item.fileId}/download"),
      ),
    );
  }
}

// network(
// "$baseurl/${_data['chatid']}/${item.fileId}/download")
