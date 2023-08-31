

import 'user_model.dart';

class UsersResponseModel {
  List<UserModel> posts;
  int totalResult;

  UsersResponseModel({required this.posts, required this.totalResult});

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      posts: (json['users'] as List)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
