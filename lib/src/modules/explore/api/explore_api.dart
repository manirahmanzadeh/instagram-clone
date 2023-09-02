import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:instagram_clone/src/modules/explore/models/explore_response_model.dart';

abstract class ExploreApi {
  Future<ExploreResponseModel> fetchPosts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    throw UnimplementedError();
  }
}

class ExploreApiMock implements ExploreApi {
  @override
  Future<ExploreResponseModel> fetchPosts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
        await rootBundle.loadString('assets/mock/explore/data/explore_posts.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return ExploreResponseModel.fromJson(data);
  }

}
