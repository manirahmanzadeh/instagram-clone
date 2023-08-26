import 'package:flutter/material.dart';
import 'package:instagram_clone/src/modules/feed/components/story_holder.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          StoryHolder(isMe: true,),
          StoryHolder(isMe: false,),
          StoryHolder(isMe: false,),
          StoryHolder(isMe: false,),
          StoryHolder(isMe: false,),
          StoryHolder(isMe: false,),
        ],
      ),
    );
  }
}
