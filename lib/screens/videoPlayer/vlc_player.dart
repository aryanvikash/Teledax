import 'dart:async';

import 'package:Teledax/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// void main() => runApp(
//       MaterialApp(
//         home: MyVlc(),
//       ),
//     );

class MyVlc extends StatefulWidget {
  String videourl;
  MyVlc({
    this.videourl,
  });
  @override
  _MyVlcState createState() => _MyVlcState();
}

class _MyVlcState extends State<MyVlc> {
  // Uint8List image;
  bool _visible = false;
  VlcPlayerController _videoViewController;

  bool isPlaying = true;
  double sliderValue = 0.0;
  double currentPlayerTime = 0;
  double volumeValue = 100;

  @override
  void initState() {
    // Oriantation force
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // vlc controller
    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });
    _videoViewController.addListener(() {
      setState(() {
        // print(_videoViewController.playingState.toString());
      });
    });

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      String state = _videoViewController.playingState.toString();
      if (this.mounted) {
        setState(() {
          if (state == "PlayingState.PLAYING" &&
              sliderValue < _videoViewController.duration.inSeconds) {
            sliderValue = _videoViewController.position.inSeconds.toDouble();
          }
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    // oriantaion back to normal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // player dispose
    _videoViewController.dispose();

    super.dispose();
  }

  // Ui part here

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // print(_videoViewController.playingState.toString());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          _visible = !_visible;
          setState(() {});
        },
        child: Stack(children: [
          Container(
            height: size.height,
            width: size.width,
            child: new VlcPlayer(
              aspectRatio: size.width / size.height,
              url: widget.videourl,
              controller: _videoViewController,
              // Play with vlc options
              options: [
                '--quiet',
                '--drop-late-frames',
                '--skip-frames',
                '--rtsp-tcp'
              ],
              hwAcc: HwAcc.DISABLED,
              // or {HwAcc.AUTO, HwAcc.DECODING, HwAcc.FULL}
            ),
          ),
          Container(color: Colors.transparent, child: null),
          Center(
            child: Visibility(
              visible: _visible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      print("backword");
                      _videoViewController.setTime(
                          (_videoViewController.position.inSeconds - 10) *
                              1000);
                    },
                    child: SizedBox(
                      height: size.height / 1.5,
                      width: size.width / 2.5,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _playPause();
                    },
                    child: Icon(
                      _videoViewController.playingState.toString() !=
                              "PlayingState.PLAYING"
                          ? MdiIcons.playCircle
                          : MdiIcons.pauseCircle,
                      size: 150,
                      color: accents,
                    ),
                  ),
                  GestureDetector(
                    onDoubleTap: () {
                      // print(_videoViewController.position.inSeconds.toString());
                      print("forwadddd");
                      _videoViewController.setTime(
                          (_videoViewController.position.inSeconds + 10) *
                              1000);
                    },
                    child: SizedBox(
                      width: size.width / 2.5,
                      height: size.height / 1.5,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Center(
              child: _videoViewController.playingState.toString() ==
                      "PlayingState.STOPPED"
                  ? CircularProgressIndicator(
                      backgroundColor: SecondaryColor,
                    )
                  : null),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 3.0,
            child: Visibility(
              visible: _visible,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 1,
                      child: Text(
                        (_videoViewController.position.inSeconds).toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  Expanded(
                    flex: 10,
                    child: _customSlider(),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      _videoViewController.duration == null
                          ? "1.0"
                          : (_videoViewController.duration.inSeconds.toDouble())
                              .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _customSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[100],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        thumbColor: SecondaryColor,
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
        value: sliderValue,
        min: 0.0,
        max: _videoViewController.duration == null
            ? 1.0
            : _videoViewController.duration.inSeconds.toDouble(),
        divisions: 1000,
        onChanged: (progress) {
          setState(() {
            sliderValue = progress.floor().toDouble();
          });
          _videoViewController.setTime(sliderValue.toInt() * 1000);
          //convert to Milliseconds since VLC requires MS to set time
        },
      ),
    );
  }

  _playPause() async {
    print("playclicked");
    final state = _videoViewController.playingState.toString();
    if (state != "PlayingState.PLAYING") {
      await _videoViewController.play();
      setState(() {
        isPlaying = true;
      });
    } else {
      await _videoViewController.pause();
      setState(() {
        setState(() {
          isPlaying = false;
        });
      });
    }
  }
}
