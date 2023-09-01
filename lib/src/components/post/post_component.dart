import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/components/user_avatar.dart';
import 'package:instagram_clone/src/models/post/post_model.dart';

import '../../models/users/user_model.dart';
import 'display/post_display.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({
    Key? key,
    required this.post,
    required this.muteUnMute,
    required this.soundOpen,
    required this.indicatorsDisplayed,
    required this.displayIndicators,
    required this.likeUnlikePost,
    required this.saveUnSavePost,
    required this.usersPagingController,
    required this.refreshUsers,
  }) : super(key: key);
  final PostModel post;
  final void Function() muteUnMute;
  final bool soundOpen;
  final bool indicatorsDisplayed;
  final Future<void> Function() displayIndicators;
  final Future<void> Function() likeUnlikePost;
  final Future<void> Function() saveUnSavePost;
  final PagingController<int, UserModel> usersPagingController;
  final Function() refreshUsers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              UserAvatar(
                size: 41,
                user: post.user,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                post.user.username,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        PostDisplay(
          medias: post.medias,
          muteUnMute: muteUnMute,
          soundOpen: soundOpen,
          displayIndicators: displayIndicators,
          indicatorsDisplayed: indicatorsDisplayed,
          likeUnlikePost: likeUnlikePost,
          saveUnSavePost: saveUnSavePost,
          liked: post.liked,
          saved: post.saved,
          refreshUsers: refreshUsers,
          usersPagingController: usersPagingController,
          postId: post.id,
          postAspectRatio: post.aspectRatio,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: 'Liked by  ',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: post.peopleLiked
                            .map(
                              (e) => TextSpan(
                                text: '$e, ',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                            .toList() +
                        <TextSpan>[
                          const TextSpan(text: 'and '),
                          TextSpan(
                            text:
                                '${post.likesNumber - post.peopleLiked.length} others',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            children: [
              Text(
                '${post.user.username} ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ExpandableText(post.caption, expandText: 'more', collapseText: 'less'),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'View ${post.commentsNumber} comments',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF8A8A8A),
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
