import 'package:flutter/material.dart';

import 'page_indicator.dart';
import 'sound_indicator.dart';

class PostIndicators extends StatelessWidget {
  const PostIndicators({
    Key? key,
    required this.currentPageIndex,
    required this.totalPages,
    required this.soundOn,
    required this.displayed,
    required this.isVideo,
  }) : super(key: key);
  final int currentPageIndex;
  final int totalPages;
  final bool soundOn;
  final bool displayed;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: displayed ? 1 : 0,
      duration: const Duration(milliseconds: 350),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PageIndicator(
            currentPageIndex: currentPageIndex,
            totalPages: totalPages,
          ),
          if (isVideo) SoundIndicator(soundOn: soundOn)
        ],
      ),
    );
  }
}
