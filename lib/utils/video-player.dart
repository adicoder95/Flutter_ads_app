import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlay extends StatefulWidget {
 late String aspectRatio;


 VideoPlay({ required this.aspectRatio, super.key});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}
int videoDuration=5;
VideoPlayerController? controller;
class _VideoPlayState extends State<VideoPlay> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller= VideoPlayerController.asset('videos/myvideo.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
          _controller.setVolume(0.5);
        });
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

    });
    print("${videoDuration.toString()}duration");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      videoDuration=_controller.value.duration.inSeconds;
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          //FURTHER IMPLEMENTATION
        ],
      )
    );
  }
}
