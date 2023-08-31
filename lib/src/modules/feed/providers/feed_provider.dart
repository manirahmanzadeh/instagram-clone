import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/apis/users_api.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/models/users/share_user_model.dart';

import '../../../apis/post_api.dart';
import '../../../models/post/post_model.dart';
import '../../../models/story/story_model.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';
import '../api/feed_api.dart';

class FeedProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  PagingController<int, PostModel> postsPagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);
  PagingController<int, ShareUserModel> shareListPagingController =
  PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);
  late List<StoryModel> stories;
  bool isLoadingStories = true;
  bool _soundOn = true;
  bool _indicatorsDisplayed = false;

  get soundOpen => _soundOn;
  get indicatorsDisplayed => _indicatorsDisplayed;

  final _feedApi = FeedApiMock();
  final _postApi = PostApiMock();
  final _usersApi = UsersApiMock();

  FeedProvider({required this.context}) {
    initFeed();
    initStories();
  }

  Future<void> initFeed() async {
    postsPagingController.addPageRequestListener((pageKey) {
      fetchPosts(pageKey);
    });
    shareListPagingController.addPageRequestListener((pageKey) {
      fetchShareList(pageKey);
    });
  }

  Future<void> fetchPosts(int pageKey) async {
    try {
      final response = await _feedApi.fetchPosts(
        offset: pageKey,
      );

      final newItems = response.posts;

      if ((pageKey + newItems.length) == response.totalResult) {
        postsPagingController.appendLastPage(newItems);
      } else {
        postsPagingController.appendPage(newItems, pageKey + newItems.length);
      }
    } on ApiError catch (e) {
      postsPagingController.error = e;
      showError(context, e);
    }
  }

  Future<void> fetchShareList(int pageKey) async {
    try {
      final response = await _usersApi.getShareList(
        offset: pageKey,
      );
      final newItems = response.users;
      if ((pageKey + newItems.length) == response.totalResult) {
        shareListPagingController.appendLastPage(newItems);
      } else {
        shareListPagingController.appendPage(newItems, pageKey + newItems.length);
      }
    } on ApiError catch (e) {
      shareListPagingController.error = e;
      showError(context, e);
    }
  }

  Future<void> initStories() async {
    isLoadingStories = true;
    notifyListeners();
    try {
      stories = await _feedApi.fetchStories();
    } on ApiError catch (e) {
      postsPagingController.error = e;
      showError(context, e);
    }
    isLoadingStories = false;
    notifyListeners();
  }

  FutureOr<void> refreshPosts() {
    postsPagingController.refresh();
  }

  void muteUnMute() {
    if(_indicatorsDisplayed){
      _soundOn = !_soundOn;
      notifyListeners();
    }
    displayIndicators();
  }

  List<int> queue = [];
  Future<void> displayIndicators() async {
    queue.add(0);
    _indicatorsDisplayed = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    queue.removeLast();
    if(queue.isEmpty){
      _indicatorsDisplayed = false;
    }
    notifyListeners();
  }


  Future<void> likeUnlikePost(PostModel item) async {
    try {
      item.liked = !item.liked;
      notifyListeners();
      await _postApi.like(item.id);
    } on ApiError catch (e) {
      showError(context, e);
    }
  }

  Future<void> saveUnSavePost(PostModel item) async {
    try {
      item.saved = !item.saved;
      notifyListeners();
      await _postApi.save(item.id);
    } on ApiError catch (e) {
      showError(context, e);
    }
  }


  refreshUsers() {
    shareListPagingController.refresh();
  }
}
