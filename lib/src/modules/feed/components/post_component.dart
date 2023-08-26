import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/user_avatar.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({Key? key}) : super(key: key);

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
              const UserAvatar(
                size: 41,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'mani.rahmanzade',
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
        Container(
          height: 375,
          width: 375,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mock/feed/images/post.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: SvgPicture.asset('assets/icons/feed/post-like.svg'),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset('assets/icons/feed/comment.svg'),
              ),
              const SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset('assets/icons/feed/send.svg'),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset('assets/icons/feed/save.svg'),
              ),
            ],
          ),
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
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Parsa Mohammadian',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' and '),
                      TextSpan(
                          text: '1,345 others',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'mani.rahmanzade ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'A good day with my friend Parsa. love you so much bro...'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text('View 103 comments', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(0xFF8A8A8A)
                ),)
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
      ],
    );
  }
}
