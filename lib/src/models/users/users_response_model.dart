

import 'share_user_model.dart';

class UsersResponseModel {
  List<ShareUserModel> users;
  int totalResult;

  UsersResponseModel({required this.users, required this.totalResult});

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      users: (json['users'] as List)
          .map((e) => ShareUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResult: json['total_results'] as int,
    );
  }
}
