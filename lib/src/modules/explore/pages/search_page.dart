import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import '../../../components/empty_state.dart';
import '../../../components/user_avatar.dart';
import '../../../models/users/user_model.dart';
import '../providers/search_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(
        context: context,
      ),
      child: const _SearchPage(),
    );
  }
}

class _SearchPage extends StatelessWidget {
  const _SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    final staticProvider = context.read<SearchProvider>();
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
                  staticProvider.refreshUsers();
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
              child: PagedListView<int, UserModel>(
                pagingController: provider.usersPagingController,
                builderDelegate: PagedChildBuilderDelegate<UserModel>(
                  itemBuilder: (context, item, index) {
                    if (index + 1 ==
                        provider.usersPagingController.itemList!.length) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: UserAvatar(
                              size: 40,
                              user: item,
                            ),
                            onTap: () => context.vRouter.to('page/${item.id}'),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.name),
                              ],
                            ),
                            subtitle: Text(item.username),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      );
                    }
                    return ListTile(
                      leading: UserAvatar(
                        size: 40,
                        user: item,
                      ),
                      onTap: (){},
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.name),
                        ],
                      ),
                      subtitle: Text(item.username),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                  newPageErrorIndicatorBuilder: (context) => IconButton(
                    onPressed: staticProvider.refreshUsers,
                    icon: const Icon(
                      Icons.refresh_rounded,
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (context) => IconButton(
                    onPressed: staticProvider.refreshUsers,
                    icon: const Icon(
                      Icons.refresh_rounded,
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const EmptyState(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
