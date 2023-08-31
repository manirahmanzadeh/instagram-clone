

import 'share_user_model.dart';

class UsersResponseModel {
  List<ShareUserModel> posts;
  int totalResult;

  UsersResponseModel({required this.posts, required this.totalResult});

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      posts: (json['users'] as List)
          .map((e) => ShareUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
