import '../../../models/post/post_model.dart';

class FeedResponseModel {
  List<PostModel> posts;
  int totalResult;

  FeedResponseModel({required this.posts, required this.totalResult});

  factory FeedResponseModel.fromJson(Map<String, dynamic> json) {
    return FeedResponseModel(
      posts: (json['posts'] as List)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
