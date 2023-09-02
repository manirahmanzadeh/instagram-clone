import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import '../../../components/empty_state.dart';
import '../../../models/post/post_model.dart';
import '../providers/explore_provider.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExploreProvider(
        context: context,
      ),
      child: const _ExplorePage(),
    );
  }
}

class _ExplorePage extends StatelessWidget {
  const _ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExploreProvider>();
    final staticProvider = context.read<ExploreProvider>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                onChanged: (v) {
                  context.vRouter.to('search');
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  isDense: true,
                  labelText: 'Search',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset(
                      'assets/icons/feed/search.svg',
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 15,
                    maxWidth: 31,
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(staticProvider.refreshPosts),
                child: PagedGridView<int, PostModel>(
                  pagingController: provider.postsPagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 100 / 100,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 3,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<PostModel>(
                    itemBuilder: (context, item, index) {
                      return InkWell(
                        onTap: () =>
                            context.vRouter.to('post_detail/${item.id}'),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: item.cover != null
                                ? DecorationImage(
                                    image: AssetImage(item.cover!.file),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                    firstPageProgressIndicatorBuilder: (context) =>
                        const Center(
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
                    noItemsFoundIndicatorBuilder: (context) =>
                        const EmptyState(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
