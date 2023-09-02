import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/apis/users_api.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';
import '../../../apis/post_api.dart';
import '../../../models/post/post_model.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';

class PostDetailProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  PagingController<int, UserModel> shareListPagingController =
  PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);
  bool _soundOn = true;
  bool _indicatorsDisplayed = false;
  late final PostModel post;
  bool isLoadingPost = true;
  final String postId;

  get soundOpen => _soundOn;
  get indicatorsDisplayed => _indicatorsDisplayed;

  final _postApi = PostApiMock();
  final _usersApi = UsersApiMock();


  PostDetailProvider({required this.context, required this.postId}) {
    initPostDetail();
  }

  Future<void> initPostDetail() async {
    shareListPagingController.addPageRequestListener((pageKey) {
      fetchShareList(pageKey);
    });
    getPostDetail();
  }

  Future<void> getPostDetail() async {
    isLoadingPost = true;
    notifyListeners();
    try {
      post = await _postApi.getPostDetail(
        postId
      );
    } on ApiError catch (e) {
      showError(context, e);
    }
    isLoadingPost = false;
    notifyListeners();
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


  FutureOr<void> refreshPost() {
    getPostDetail();
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


  Future<void> likeUnlikePost() async {
    try {
      post.liked = !post.liked;
      notifyListeners();
      await _postApi.like(post.id);
    } on ApiError catch (e) {
      showError(context, e);
    }
  }

  Future<void> saveUnSavePost() async {
    try {
      post.saved = !post.saved;
      notifyListeners();
      await _postApi.save(post.id);
    } on ApiError catch (e) {
      showError(context, e);
    }
  }


  refreshUsers() {
    shareListPagingController.refresh();
  }
}
