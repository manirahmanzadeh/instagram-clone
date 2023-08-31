

import 'package:instagram_clone/src/modules/comments/models/comment_model.dart';

class CommentsResponseModel {
  List<CommentModel> comments;
  int totalResult;

  CommentsResponseModel({required this.comments, required this.totalResult});

  factory CommentsResponseModel.fromJson(Map<String, dynamic> json) {
    return CommentsResponseModel(
      comments: (json['comments'] as List)
          .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
