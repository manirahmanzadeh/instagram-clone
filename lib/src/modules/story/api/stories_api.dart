import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';

abstract class StoriesApi {

  Future<UserModel> getUserStories(String userId);
}

class StoriesApiMock implements StoriesApi {

  @override
  Future<UserModel> getUserStories(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
    await rootBundle.loadString('assets/mock/feed/data/user_stories.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }
}
