import 'package:flutter/material.dart';
import 'package:instagram_clone/src/modules/story/components/indicators/single_story_progress_line.dart';

class StoryIndicators extends StatelessWidget {
  const StoryIndicators({
    Key? key,
    required this.storyIndex,
    required this.storiesNumber, required this.storyProgressValue,
  }) : super(key: key);
  final int storyIndex;
  final int storiesNumber;
  final double storyProgressValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: List.generate(
            storiesNumber,
            (index) => SingleStoryProgressLine(
              value: index == storyIndex ? storyProgressValue  * ((MediaQuery.sizeOf(context).width / storiesNumber)-8) : 0,
            ),
          ),
        )
      ],
    );
  }
}
