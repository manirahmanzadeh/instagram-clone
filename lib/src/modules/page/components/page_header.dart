import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/src/modules/page/models/page_model.dart';

import '../../../components/user_avatar.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.page,
  }) : super(key: key);
  final PageModel page;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                UserAvatar(
                  size: 90,
                  user: page.user,
                ),
                Expanded(child: Container()),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      page.postsNumber.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Posts',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      page.followersNumber.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Followers',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      page.followingsNumber.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Followings',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    page.user.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    page.bio,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Follow'),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFDFDFDF)),
                    ),
                    child: const Text(
                      'Message',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Expanded(child: SvgPicture.asset('assets/icons/page/grid.svg')),
              Expanded(child: SvgPicture.asset('assets/icons/page/reels.svg')),
              Expanded(child: SvgPicture.asset('assets/icons/page/tag.svg')),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
