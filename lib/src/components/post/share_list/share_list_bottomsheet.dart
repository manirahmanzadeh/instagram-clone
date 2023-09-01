import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';
import 'package:vrouter/vrouter.dart';

import '../../empty_state.dart';
import 'share_user_component.dart';

class ShareListBottomSheet extends StatefulWidget {
  const ShareListBottomSheet({
    Key? key,
    required this.usersPagingController,
    required this.refreshUsers,
  }) : super(key: key);
  final PagingController<int, UserModel> usersPagingController;
  final Function() refreshUsers;

  @override
  State<ShareListBottomSheet> createState() => _ShareListBottomSheetState();
}

class _ShareListBottomSheetState extends State<ShareListBottomSheet> {
  List<UserModel> shareList = [];

  addToShareList(UserModel shareUserModel) {
    if (shareList.any((element) => element.id == shareUserModel.id)) {
      setState(() {
        shareList.removeWhere((element) => element.id == shareUserModel.id);
      });
    } else {
      setState(() {
        shareList.add(shareUserModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 2,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              onChanged: (v) {
                widget.refreshUsers();
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
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PagedListView<int, UserModel>(
                  pagingController: widget.usersPagingController,
                  builderDelegate: PagedChildBuilderDelegate<UserModel>(
                    itemBuilder: (context, item, index) {
                      if (index + 1 ==
                          widget.usersPagingController.itemList!.length) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ShareUserComponent(
                              userModel: item,
                              addToShare: () => addToShareList(item),
                              selected: shareList
                                  .any((element) => element.id == item.id),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        );
                      }
                      return ShareUserComponent(
                        userModel: item,
                        addToShare: () => addToShareList(item),
                        selected:
                            shareList.any((element) => element.id == item.id),
                      );
                    },
                    firstPageProgressIndicatorBuilder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                    newPageErrorIndicatorBuilder: (context) => IconButton(
                      onPressed: widget.refreshUsers,
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                    ),
                    firstPageErrorIndicatorBuilder: (context) => IconButton(
                      onPressed: widget.refreshUsers,
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) =>
                        const EmptyState(),
                  ),
                ),
                if (shareList.isNotEmpty)
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        context.vRouter.pop();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Send'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
