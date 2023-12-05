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

  late final List<PostModel> posts;

  final _pageApi = PageApiMock();
  final String userId;

  late final PageModel page;

  bool isLoadingPageData = true;
  bool isLoadingPosts = true;

  PageProvider({required this.context, required this.userId}) {
    initPage();
  }

  Future<void> initPage() async {
    fetchPage();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoadingPosts = true;
    notifyListeners();
    try {
      final response = await _pageApi.fetchPosts(
        offset: 0,
      );
      posts = response.posts;

    } on ApiError catch (e) {
      showError(context, e);
    }
    isLoadingPosts = false;
    notifyListeners();
  }

  Future<void> fetchPage() async {
    isLoadingPageData = true;
    notifyListeners();
    try {
      page = await _pageApi.getPage(
        userId: userId,
      );
    } on ApiError catch (e) {
      showError(context, e);
    }
    isLoadingPageData = false;
    notifyListeners();
  }

  FutureOr<void> refreshPosts() {
    // postsPagingController.refresh();
  }


}
