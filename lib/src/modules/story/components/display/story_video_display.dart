import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryVideoDisplay extends StatefulWidget {
  const StoryVideoDisplay({
    Key? key,
    required this.video,
  }) : super(key: key);
  final String video;


  @override
  State<StoryVideoDisplay> createState() => _StoryVideoDisplayState();
}

class _StoryVideoDisplayState extends State<StoryVideoDisplay> {
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
    return controller == null
        ? const Center(child: CircularProgressIndicator())
        : VideoPlayer(controller!);
  }
}
