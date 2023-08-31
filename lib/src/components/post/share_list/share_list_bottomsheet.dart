import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';

import '../../empty_state.dart';
import '../../user_component.dart';

class ShareListBottomSheet extends StatelessWidget {
  const ShareListBottomSheet({
    Key? key,
    required this.usersPagingController,
    required this.refreshUsers,
  }) : super(key: key);
  final PagingController<int, UserModel> usersPagingController;
  final Function() refreshUsers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 2,
      child: PagedListView<int, UserModel>(
        pagingController: usersPagingController,
        builderDelegate: PagedChildBuilderDelegate<UserModel>(
          itemBuilder: (context, item, index) {
            return UserComponent(userModel: item);
          },
          firstPageProgressIndicatorBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          newPageErrorIndicatorBuilder: (context) => IconButton(
            onPressed: refreshUsers,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
          firstPageErrorIndicatorBuilder: (context) => IconButton(
            onPressed: refreshUsers,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) => const EmptyState(),
        ),
      ),
    );
  }
}
