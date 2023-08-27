import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../components/empty_state.dart';
import '../../../models/post/post_model.dart';
import '../components/post/post_component.dart';
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
    final provider = context.watch<FeedProvider>();
    final staticProvider = context.read<FeedProvider>();
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
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/feed/add.svg')),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/feed/like.svg')),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/feed/dm.svg')),
        ],
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(staticProvider.refreshPosts),
        child: PagedListView<int, PostModel>(
          pagingController: provider.postsPagingController,
          builderDelegate: PagedChildBuilderDelegate<PostModel>(
            itemBuilder: (context, item, index) {
              if (index == 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StoriesSection(
                      stories: provider.stories,
                      isLoading: provider.isLoadingStories,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: PostComponent(
                        post: item,
                        muteUnMute: staticProvider.muteUnMute,
                        soundOpen: provider.soundOpen,
                        indicatorsDisplayed: provider.indicatorsDisplayed,
                        displayIndicators: staticProvider.displayIndicators,
                      ),
                    ),
                  ],
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: PostComponent(
                  post: item,
                  muteUnMute: staticProvider.muteUnMute,
                  soundOpen: provider.soundOpen,
                  indicatorsDisplayed: provider.indicatorsDisplayed,
                  displayIndicators: staticProvider.displayIndicators,
                ),
              );
            },
            firstPageProgressIndicatorBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            newPageErrorIndicatorBuilder: (context) => IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh_rounded,
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) => IconButton(
              onPressed: staticProvider.refreshPosts,
              icon: const Icon(
                Icons.refresh_rounded,
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => const EmptyState(),
          ),
        ),
      ),
    );
  }
}
