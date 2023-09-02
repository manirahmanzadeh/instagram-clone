import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/components/user_avatar.dart';
import 'package:instagram_clone/src/modules/page/providers/page_provider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../../components/empty_state.dart';
import '../../../models/post/post_model.dart';

class PagePage extends StatelessWidget {
  const PagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.vRouter.pathParameters['user_id'] ?? '';
    return ChangeNotifierProvider(
      create: (_) => PageProvider(
        context: context,
        userId: userId,
      ),
      child: const _PagePage(),
    );
  }
}

class _PagePage extends StatelessWidget {
  const _PagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PageProvider>();
    final staticProvider = context.read<PageProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: provider.isLoadingPageData
              ? const Text('is loading data')
              : Text(provider.page.user.username),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: provider.isLoadingPageData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Row(
                      children: [
                        UserAvatar(
                          size: 90,
                          user: provider.page.user,
                        ),
                        Expanded(child: Container()),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              provider.page.postsNumber.toString(),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                              provider.page.followersNumber.toString(),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                              provider.page.followingsNumber.toString(),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Followings',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                        Text(
                          provider.page.user.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
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
                            provider.page.bio,
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
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFDFDFDF)),
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
                  const Row(
                    children: [
                      Expanded(child: Icon(Icons.grid_on)),
                      Expanded(child: Icon(Icons.play_circle)),
                      Expanded(child: Icon(Icons.add_a_photo_outlined)),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(staticProvider.refreshPosts),
                      child: PagedGridView<int, PostModel>(
                        pagingController: provider.postsPagingController,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                          firstPageErrorIndicatorBuilder: (context) =>
                              IconButton(
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
