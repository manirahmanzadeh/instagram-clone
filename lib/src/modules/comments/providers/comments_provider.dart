import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/modules/comments/api/comments_api.dart';
import 'package:instagram_clone/src/modules/comments/models/comment_model.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';

class CommentsProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  final String postId;
  PagingController<int, CommentModel> commentsPagingController =
  PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  final _commentsApi = CommentsApiMock();

  CommentsProvider({required this.context, required this.postId}) {
    initComments();
  }

  Future<void> initComments() async {
    commentsPagingController.addPageRequestListener((pageKey) {
      fetchComments(pageKey);
    });
  }

  Future<void> fetchComments(int pageKey) async {
    try {
      final response = await _commentsApi.getComments(
        offset: pageKey,
        postId: postId,
      );

      final newItems = response.comments;

      if ((pageKey + newItems.length) == response.totalResult) {
        commentsPagingController.appendLastPage(newItems);
      } else {
        commentsPagingController.appendPage(newItems, pageKey + newItems.length);
      }
    } on ApiError catch (e) {
      commentsPagingController.error = e;
      showError(context, e);
    }
  }


  FutureOr<void> refreshComments() {
    commentsPagingController.refresh();
  }

  Future<void> likeComment(CommentModel item)async{
    try {
      item.liked = !item.liked;
      if(item.liked){
        item.likesNumber++;
      } else {
        item.likesNumber--;
      }
      notifyListeners();
      await _commentsApi.likeComment(commentId: item.id);
    } on ApiError catch (e) {
      showError(context, e);
    }
  }
}
