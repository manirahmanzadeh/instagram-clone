import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/modules/page/components/page_header.dart';
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
    return Scaffold(
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
          : CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: 260.0,
              leading: Container(),
              floating: false,
              pinned: false,
              flexibleSpace: PageHeader(page: provider.page)
          ),

          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 100 / 100,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
            ),
            itemCount: provider.posts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () =>
                    context.vRouter.to('post_detail/${provider.posts[index].id}'),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: provider.posts[index].cover != null
                        ? DecorationImage(
                      image: AssetImage(provider.posts[index].cover!.file),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
