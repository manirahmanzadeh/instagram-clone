import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/models/file_model.dart';
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
        commentsPagingController.appendPage(
            newItems, pageKey + newItems.length);
      }
    } on ApiError catch (e) {
      commentsPagingController.error = e;
      showError(context, e);
    }
  }

  FutureOr<void> refreshComments() {
    commentsPagingController.refresh();
  }

  Future<void> likeComment(CommentModel item) async {
    try {
      item.liked = !item.liked;
      if (item.liked) {
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

  final commentFormKey = GlobalKey<FormState>();
  String commentText = '';
  TextEditingController textEditingController = TextEditingController();

  void saveComment(String? text) {
    commentText = text ?? '';
  }

  Future<void> sendComment() async {
    try {
      commentFormKey.currentState!.save();
      if (commentText.isNotEmpty) {
        commentsPagingController.itemList!.add(
          CommentModel(
            id: '0',
            username: 'mani.rahmanzadeh',
            userAvatar: const FileModel(file: 'assets/mock/feed/images/me.png'),
            text: commentText,
            likesNumber: 0,
            liked: false,
          ),
        );
        textEditingController.clear();
        notifyListeners();
        await _commentsApi.sendComment(text: commentText);
      }
    } on ApiError catch (e) {
      showError(context, e);
    }
  }
}
