import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/post/indicators/sound_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoDisplay extends StatefulWidget {
  const VideoDisplay({
    Key? key,
    required this.video,
    required this.muteUnMute,
    required this.soundOpen,
    required this.displayIndicators,
    required this.soundIndicatorDisplay,
  }) : super(key: key);
  final String video;
  final bool soundOpen;
  final bool soundIndicatorDisplay;
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
    if (widget.soundIndicatorDisplay) {
      await controller?.setVolume(widget.soundOpen ? 0 : 1);
    }
    widget.muteUnMute();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: muteUnMute,
      child: controller == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.bottomRight,
              children: [
                VideoPlayer(controller!),
                AnimatedOpacity(
                  opacity: widget.soundIndicatorDisplay ? 1 : 0,
                  duration: const Duration(milliseconds: 350),
                  child: SoundIndicator(soundOn: widget.soundOpen),
                ),
              ],
            ),
    );
  }
}
