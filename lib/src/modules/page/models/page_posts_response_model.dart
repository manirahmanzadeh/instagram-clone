import 'package:instagram_clone/src/models/post/post_model.dart';
class PagePostsResponseModel {
  List<PostModel> posts;
  int totalResult;

  PagePostsResponseModel({required this.posts, required this.totalResult});

  factory PagePostsResponseModel.fromJson(Map<String, dynamic> json) {
    return PagePostsResponseModel(
      posts: (json['posts'] as List)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
