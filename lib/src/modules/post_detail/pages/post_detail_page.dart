import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/post/post_component.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../providers/post_detail_provider.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    String postId = context.vRouter.pathParameters['post_id'] ?? '';
    return ChangeNotifierProvider(
      create: (_) => PostDetailProvider(
        context: context,
        postId: postId,
      ),
      child: const _PostDetailPage(),
    );
  }
}

class _PostDetailPage extends StatelessWidget {
  const _PostDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostDetailProvider>();
    final staticProvider = context.read<PostDetailProvider>();
    return SafeArea(
      child: Scaffold(
        body: provider.isLoadingPost
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PostComponent(
                post: provider.post,
                muteUnMute: staticProvider.muteUnMute,
                soundOpen: provider.soundOpen,
                indicatorsDisplayed: provider.indicatorsDisplayed,
                displayIndicators: staticProvider.displayIndicators,
                likeUnlikePost: staticProvider.likeUnlikePost,
                saveUnSavePost: staticProvider.saveUnSavePost,
                usersPagingController: provider.shareListPagingController,
                refreshUsers: staticProvider.refreshUsers,
              ),
      ),
    );
  }
}
