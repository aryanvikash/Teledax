import 'package:Teledax/style/constants.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:video_player/video_player.dart';

class MyCustomVideoPlayer extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;

  MyCustomVideoPlayer({
    @required this.videoPlayerController,
    this.looping,
    Key key,
  }) : super(key: key);

  @override
  _MyCustomVideoPlayerState createState() => _MyCustomVideoPlayerState();
}

class _MyCustomVideoPlayerState extends State<MyCustomVideoPlayer> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      allowedScreenSleep: false,
      allowFullScreen: true,
      autoPlay: true,
      fullScreenByDefault: true,
      showControlsOnInitialize: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: lightColor,
        bufferedColor: Colors.lightGreen,
      ),

      errorBuilder: (context, errorMessage) {
        //TODO Add better error builder
        Fluttertoast.showToast(
            msg: errorMessage.toString(),
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: accents,
            gravity: ToastGravity.BOTTOM);
        return Scaffold(
          body: Center(
              child: Column(
            children: [
              Text(
                errorMessage.toString(),
                style: TextStyle(color: fontColor, backgroundColor: lightColor),
                textAlign: TextAlign.center,
              ),
              IconButton(
                icon: Icon(MdiIcons.backspace),
                onPressed: () => Navigator.pop(context),
              )
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }

  // Have To000 Dispose player after use can cause memory leak
  @override
  void dispose() {
    _chewieController.videoPlayerController.dispose();
    _chewieController.dispose();
    widget.videoPlayerController.dispose();
    super.dispose();
  }
}
