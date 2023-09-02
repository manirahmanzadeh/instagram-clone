import 'package:instagram_clone/src/models/users/user_model.dart';

class PageModel {
  final String id;
  final UserModel user;
  final String bio;
  final int followersNumber;
  final int followingsNumber;
  final int postsNumber;

  const PageModel({
    required this.id,
    required this.user,
    required this.bio,
    required this.followersNumber,
    required this.followingsNumber,
    required this.postsNumber,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user']),
      bio: json['bio'] as String,
      followersNumber: json['followers_number'] as int,
      followingsNumber: json['followings_number'] as int,
      postsNumber: json['posts_number'] as int,
    );
  }
}
