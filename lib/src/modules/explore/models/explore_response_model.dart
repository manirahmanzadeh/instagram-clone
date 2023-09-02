import 'package:instagram_clone/src/modules/explore/models/explore_post.dart';
class ExploreResponseModel {
  List<ExplorePostModel> posts;
  int totalResult;

  ExploreResponseModel({required this.posts, required this.totalResult});

  factory ExploreResponseModel.fromJson(Map<String, dynamic> json) {
    return ExploreResponseModel(
      posts: (json['posts'] as List)
          .map((e) => ExplorePostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
