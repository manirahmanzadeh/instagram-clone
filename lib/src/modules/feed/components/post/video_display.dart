import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatefulWidget {
  const VideoDisplay({
    Key? key,
    required this.video,
    required this.muteUnMute,
    required this.soundOpen,
    required this.displayIndicators,
  }) : super(key: key);
  final String video;
  final bool soundOpen;
  final void Function() muteUnMute;
  final void Function() displayIndicators;

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
    controller!.setVolume(widget.soundOpen ? 1 : 0);

    await controller!.initialize();
    controller!.play();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> muteUnMute() async {
    await controller?.setVolume(widget.soundOpen ? 0 : 1);
    widget.muteUnMute();
    widget.displayIndicators();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: muteUnMute,
      child: SizedBox(
        height: 357,
        child: controller == null
            ? const Center(child: CircularProgressIndicator())
            : VideoPlayer(controller!),
      ),
    );
  }
}
