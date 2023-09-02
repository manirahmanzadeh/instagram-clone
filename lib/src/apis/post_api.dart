
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/post/post_model.dart';

abstract class PostApi {

  Future<PostModel> getPostDetail(
      final String postId,
      ) async {
    throw UnimplementedError();
  }


  Future<void> like(
    final String postId,
  ) async {
    throw UnimplementedError();
  }

  Future<void> save(
      final String postId,
      ) async {
    throw UnimplementedError();
  }

  Future<void> comment(
      final String postId,
      final String text,
      ) async {
    throw UnimplementedError();
  }

}

class PostApiMock implements PostApi {

  @override
  Future<void> like(
    final String postId,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> save(
      final String postId,
      ) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> comment(
      final String postId,
      final String text,
      ) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<PostModel> getPostDetail(String postId) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
        await rootBundle.loadString('assets/mock/post_detail/data/post_detail.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return PostModel.fromJson(data);
  }

}
