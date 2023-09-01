import 'package:flutter/material.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';
import 'package:instagram_clone/src/modules/story/components/indicators/single_story_progress_line.dart';

import '../../../../components/user_avatar.dart';

class StoryIndicators extends StatelessWidget {
  const StoryIndicators({
    Key? key,
    required this.storyIndex,
    required this.storyProgressValue,
    required this.user,
  }) : super(key: key);
  final int storyIndex;
  final UserModel user;
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
            user.stories.length,
            (index) => SingleStoryProgressLine(
              value: index == storyIndex
                  ? storyProgressValue *
                      ((MediaQuery.sizeOf(context).width /
                              user.stories.length) -
                          8)
                  : 0,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            UserAvatar(
              size: 40,
              user: user,
              showStoryIndicator: false,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              user.username,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
