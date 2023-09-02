import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:instagram_clone/src/modules/page/models/page_posts_response_model.dart';
import '../models/page_model.dart';

abstract class PageApi {
  Future<PageModel> getPage({
    required String userId,
  }) async {
    throw UnimplementedError();
  }

  Future<PagePostsResponseModel> fetchPosts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    throw UnimplementedError();
  }

}

class PageApiMock implements PageApi {
  @override
  Future<PageModel> getPage({
    required String userId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
    await rootBundle.loadString('assets/mock/page/data/page.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return PageModel.fromJson(data);
  }

  @override
  Future<PagePostsResponseModel> fetchPosts({
    final int limit = 10,
    final int offset = 0,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
    await rootBundle.loadString('assets/mock/page/data/page_posts.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return PagePostsResponseModel.fromJson(data);
  }
}
