import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../components/post_component.dart';
import '../components/stories_section.dart';
import '../providers/feed_provider.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeedProvider(
        context: context,
      ),
      child: const _FeedPage(),
    );
  }
}

class _FeedPage extends StatelessWidget {
  const _FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finstagram',
          style: TextStyle(
            fontFamily: 'bill',
            fontSize: 35,
          ),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/feed/add.svg')),
          IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/feed/like.svg')),
          IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/feed/dm.svg')),
        ],
        elevation: 0,
      ),
      body: ListView(
        children: const [
          StoriesSection(),
          PostComponent(),
          PostComponent(),
        ],
      )
    );
  }
}
