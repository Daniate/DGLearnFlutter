import 'package:flutter/material.dart';
import 'package:flutter_play_video/flutter_vlc_player/vlc_player_with_controls.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class PageVLCPlayer extends StatefulWidget {
  const PageVLCPlayer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageVLCPlayerState();
  }
}

class _PageVLCPlayerState extends State<PageVLCPlayer> {
  VlcPlayerController? _vlcPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _vlcPlayerController = VlcPlayerController.asset(
      'assets/videos/apple.mp4',
      hwAcc: HwAcc.full,
      autoPlay: false,
      autoInitialize: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VLC Player"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 400,
              child: VlcPlayerWithControls(controller: _vlcPlayerController!),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _vlcPlayerController!.stop();
    await _vlcPlayerController!.stopRendererScanning();
    await _vlcPlayerController!.dispose();
  }
}
