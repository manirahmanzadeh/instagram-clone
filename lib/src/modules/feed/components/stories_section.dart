import 'package:flutter/material.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';

import '../../../components/user_avatar.dart';
import 'my_story_holder.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection(
      {Key? key, required this.stories, required this.isLoading})
      : super(key: key);
  final List<UserModel> stories;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: isLoading
            ? const CircularProgressIndicator()
            : ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.5),
                        child: MyStoryHolder(),
                      ),
                    ] +
                    stories
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.5),
                            child: UserAvatar(
                              size: 73,
                              user: e,
                            ),
                          ),
                        )
                        .toList(),
              ),
      ),
    );
  }
}
