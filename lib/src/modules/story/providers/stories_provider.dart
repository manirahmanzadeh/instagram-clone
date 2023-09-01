import 'dart:async';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';
import 'package:instagram_clone/src/modules/story/api/stories_api.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';

class StoriesProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  final String userId;
  late final UserModel user;
  bool isLoadingStories = true;

  final _storiesApi = StoriesApiMock();

  StoriesProvider({required this.context, required this.userId}) {
    initComments();
  }

  Future<void> initComments() async {
    fetchStories();
  }

  Future<void> fetchStories() async {
    isLoadingStories = true;
    notifyListeners();
    try {
      user = await _storiesApi.getUserStories(
        userId,
      );
    } on ApiError catch (e) {
      showError(context, e);
    }
    isLoadingStories = false;
    notifyListeners();
  }

}
