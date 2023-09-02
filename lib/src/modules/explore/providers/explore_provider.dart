import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/models/post/post_model.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';
import '../api/explore_api.dart';

class ExploreProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  PagingController<int, PostModel> postsPagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  final _exploreApi = ExploreApiMock();

  ExploreProvider({required this.context}) {
    initPosts();
  }

  Future<void> initPosts() async {
    postsPagingController.addPageRequestListener((pageKey) {
      fetchPosts(pageKey);
    });
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      final response = await _exploreApi.fetchPosts(
        offset: pageKey,
      );

      final newItems = response.posts;

      if ((pageKey + newItems.length) == response.totalResult) {
        postsPagingController.appendLastPage(newItems);
      } else {
        postsPagingController.appendPage(
            newItems, pageKey + newItems.length);
      }
    } on ApiError catch (e) {
      postsPagingController.error = e;
      showError(context, e);
    }
  }

  FutureOr<void> refreshPosts() {
    postsPagingController.refresh();
  }


}
