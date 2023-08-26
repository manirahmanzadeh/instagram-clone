import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/user_avatar.dart';

import 'my_story_holder.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          Padding(padding: EdgeInsets.symmetric(horizontal: 6.5), child: MyStoryHolder(),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 6.5), child: UserAvatar(size: 73,),),
          Padding(padding: EdgeInsets.symmetric(horizontal: 6.5), child: UserAvatar(size: 73,),),
        ],
      ),
    );
  }
}
