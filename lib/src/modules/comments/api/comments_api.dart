import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:instagram_clone/src/modules/comments/models/comments_response_model.dart';

abstract class CommentsApi {
  Future<CommentsResponseModel> getComments({
    final int limit = 10,
    final int offset = 0,
    required String postId,
  }) async {
    throw UnimplementedError();
  }

  Future<void> likeComment({
    required String commentId,
  }) async {
    throw UnimplementedError();
  }

  Future<void> sendComment({
    required String text,
  }) async {
    throw UnimplementedError();
  }

}

class CommentsApiMock implements CommentsApi {
  @override
  Future<CommentsResponseModel> getComments({
    final int limit = 10,
    final int offset = 0,
    required String postId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final response =
    await rootBundle.loadString('assets/mock/feed/data/comments.json');
    final data = jsonDecode(response) as Map<String, dynamic>;
    return CommentsResponseModel.fromJson(data);
  }

  @override
  Future<void> likeComment({
    required String commentId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendComment({required String text}) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
