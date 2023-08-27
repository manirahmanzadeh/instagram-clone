import 'package:flutter/material.dart';

import '../../../../components/user_avatar.dart';
import '../../../../models/post/post_model.dart';
import 'display/post_display.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({
    Key? key,
    required this.post,
    required this.muteUnMute,
    required this.soundOpen,
    required this.indicatorsDisplayed,
    required this.displayIndicators,
  }) : super(key: key);
  final PostModel post;
  final void Function() muteUnMute;
  final bool soundOpen;
  final bool indicatorsDisplayed;
  final Future<void> Function() displayIndicators;

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
                image: post.userAvatar,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                post.username,
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
          images: post.files,
          muteUnMute: muteUnMute,
          soundOpen: soundOpen,
          displayIndicators: displayIndicators,
          indicatorsDisplayed: indicatorsDisplayed,
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
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: '${post.username} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: post.caption,
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
