import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/models/post/post_model.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';
import '../api/page_api.dart';
import '../models/page_model.dart';

class PageProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  PagingController<int, PostModel> postsPagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  final _pageApi = PageApiMock();
  final String userId;

  late final PageModel page;

  bool isLoadingPageData = true;

  PageProvider({required this.context, required this.userId}) {
    initPage();
  }

  Future<void> initPage() async {
    fetchPage();
    postsPagingController.addPageRequestListener((pageKey) {
      fetchPosts(pageKey);
    });
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      final response = await _pageApi.fetchPosts(
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

  Future<void> fetchPage() async {
    isLoadingPageData = true;
    notifyListeners();
    try {
      page = await _pageApi.getPage(
        userId: userId,
      );
    } on ApiError catch (e) {
      postsPagingController.error = e;
      showError(context, e);
    }
    isLoadingPageData = false;
    notifyListeners();
  }

  FutureOr<void> refreshPosts() {
    postsPagingController.refresh();
  }


}
