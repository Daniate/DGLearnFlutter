import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PageVideoPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageVideoPlayerState();
  }
}

class _PageVideoPlayerState extends State<PageVideoPlayer> {
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset(
      'assets/videos/apple.mp4',
      videoPlayerOptions: VideoPlayerOptions(),
    )
      ..addListener(() {
        // 播放到结尾时，刷新状态，变更按钮图标
        if (0 ==
            _videoPlayerController!.value.position
                .compareTo(_videoPlayerController!.value.duration)) {
          setState(() {});
        }
      })
      ..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController!.dispose();
  }

  Future<void> _togglePlay() async {
    setState(() {
      _videoPlayerController!.value.isPlaying
          ? _videoPlayerController!.pause()
          : _videoPlayerController!.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blueAccent,
              height: 200,
              child: _videoPlayerController!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController!),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        child: Icon(_videoPlayerController!.value.isPlaying
            ? Icons.pause_circle_outline
            : Icons.play_circle_outline),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
