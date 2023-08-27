import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatefulWidget {
  const VideoDisplay({
    Key? key,
    required this.video, required this.muteUnMute, required this.soundOpen,
  }) : super(key: key);
  final String video;
  final bool soundOpen;
  final void Function() muteUnMute;

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  late final VideoPlayerController? controller;

  @override
  void initState() {
    initializeController();
    super.initState();
  }

  Future<void> initializeController() async {
    controller = VideoPlayerController.asset(
      widget.video,
      videoPlayerOptions: VideoPlayerOptions(
        allowBackgroundPlayback: false,
      ),
    );
    controller!.setLooping(true);
    controller!.setVolume(widget.soundOpen ?1 :0);

    await controller!.initialize();
    controller!.play();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.muteUnMute();
        controller?.setVolume(widget.soundOpen ?1 :0);
      },
      child: SizedBox(
        height: 357,
        child: controller == null
            ? const Center(child: CircularProgressIndicator())
            : VideoPlayer(controller!),
      ),
    );
  }
}
