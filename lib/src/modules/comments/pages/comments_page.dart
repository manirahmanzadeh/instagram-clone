import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/components/user_avatar.dart';
import 'package:instagram_clone/src/modules/comments/models/comment_model.dart';
import 'package:instagram_clone/src/modules/comments/providers/comments_provider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../../../components/empty_state.dart';
import '../components/comment_form.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String postId = context.vRouter.pathParameters['post_id'] ?? '';
    return ChangeNotifierProvider(
      create: (_) => CommentsProvider(
        context: context,
        postId: postId,
      ),
      child: const _CommentsPage(),
    );
  }
}

class _CommentsPage extends StatelessWidget {
  const _CommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CommentsProvider>();
    final staticProvider = context.read<CommentsProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(staticProvider.refreshComments),
              child: PagedListView<int, CommentModel>(
                pagingController: provider.commentsPagingController,
                builderDelegate: PagedChildBuilderDelegate<CommentModel>(
                  itemBuilder: (context, item, index) {
                    return ListTile(
                      leading: UserAvatar(
                        size: 40,
                        image: item.user.userAvatar,
                        newStory: item.user.newStory,
                        hasStory: item.user.hasStory,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.user.username),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => staticProvider.likeComment(item),
                                child: item.liked
                                    ? SvgPicture.asset(
                                        'assets/icons/post/like_filled.svg',
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/post/like_outlined.svg',
                                      ),
                              ),
                              Text(
                                item.likesNumber.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            ],
                          ),
                        ],
                      ),
                      subtitle: Text(
                        item.text,
                        style: Theme.of(context).textTheme.bodyMedium,
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
                    onPressed: staticProvider.refreshComments,
                    icon: const Icon(
                      Icons.refresh_rounded,
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const EmptyState(),
                ),
              ),
            ),
          ),
          const Divider(),
          CommentForm(
            formKey: staticProvider.commentFormKey,
            saveComment: staticProvider.saveComment,
            sendComment: staticProvider.sendComment,
            controller: staticProvider.textEditingController,
          ),
        ],
      ),
    );
  }
}
