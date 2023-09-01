import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/post/display/image_display.dart';
import 'package:instagram_clone/src/models/media_model.dart';
import 'package:instagram_clone/src/models/story/story_model.dart';

import 'story_video_display.dart';

class StoryDisplay extends StatefulWidget {
  final Function(
    int index,
    CarouselPageChangedReason reason,
  ) onStoryChanged;

  const StoryDisplay({
    Key? key,
    required this.stories,
    required this.storiesController,
    required this.onStoryChanged,
  }) : super(key: key);
  final List<StoryModel> stories;
  final CarouselController storiesController;

  @override
  State<StoryDisplay> createState() => _StoryDisplayState();
}

class _StoryDisplayState extends State<StoryDisplay>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        aspectRatio: 9 / 16,
        enableInfiniteScroll: false,
        onPageChanged: widget.onStoryChanged,
      ),
      carouselController: widget.storiesController,
      items: widget.stories.map((e) {
        if (e.media.fileType == FileType.image) {
          return ImageDisplay(image: e.media.file.file);
        } else {
          return StoryVideoDisplay(video: e.media.file.file);
        }
      }).toList(),
    );
  }

  void nextStory() {}

  void previousStory() {}
}
