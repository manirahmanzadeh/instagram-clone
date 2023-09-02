import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import '../../../apis/users_api.dart';
import '../../../models/users/user_model.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';

class SearchProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  PagingController<int, UserModel> usersPagingController =
  PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  final _usersApi = UsersApiMock();


  SearchProvider({required this.context}) {
    initSearch();
  }


  Future<void> initSearch() async {
    usersPagingController.addPageRequestListener((pageKey) {
      fetchShareList(pageKey);
    });
  }

  Future<void> fetchShareList(int pageKey) async {
    try {
      final response = await _usersApi.getShareList(
        offset: pageKey,
      );
      final newItems = response.users;
      if ((pageKey + newItems.length) == response.totalResult) {
        usersPagingController.appendLastPage(newItems);
      } else {
        usersPagingController.appendPage(newItems, pageKey + newItems.length);
      }
    } on ApiError catch (e) {
      usersPagingController.error = e;
      showError(context, e);
    }
  }





  void refreshUsers() {
    usersPagingController.refresh();
  }
}
