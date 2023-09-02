import 'package:instagram_clone/src/models/post/post_model.dart';
class ExploreResponseModel {
  List<PostModel> posts;
  int totalResult;

  ExploreResponseModel({required this.posts, required this.totalResult});

  factory ExploreResponseModel.fromJson(Map<String, dynamic> json) {
    return ExploreResponseModel(
      posts: (json['posts'] as List)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
