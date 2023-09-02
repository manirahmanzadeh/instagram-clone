import 'package:flutter/material.dart';

import 'page_indicator.dart';

class PostIndicators extends StatelessWidget {
  const PostIndicators({
    Key? key,
    required this.currentPageIndex,
    required this.totalPages,
    required this.soundOn,
    required this.displayed,
  }) : super(key: key);
  final int currentPageIndex;
  final int totalPages;
  final bool soundOn;
  final bool displayed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: displayed ? 1 : 0,
      duration: const Duration(milliseconds: 350),
      child: PageIndicator(
        currentPageIndex: currentPageIndex,
        totalPages: totalPages,
      ),
    );
  }
}
