import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:instagram_clone/src/models/story/story_model.dart';
import 'package:instagram_clone/src/modules/feed/models/feed_response_model.dart';

abstract class FeedApi {
  Future<FeedResponseModel> fetchPosts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    throw UnimplementedError();
  }

  Future<List<StoryModel>> fetchStories();
}

class FeedApiMock implements FeedApi {
  @override
  Future<FeedResponseModel> fetchPosts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
        await rootBundle.loadString('assets/mock/feed/data/feed_posts.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return FeedResponseModel.fromJson(data);
  }

  @override
  Future<List<StoryModel>> fetchStories() async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
        await rootBundle.loadString('assets/mock/feed/data/feed_stories.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return (data['stories'] as List)
        .map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
