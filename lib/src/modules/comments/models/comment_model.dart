import 'package:instagram_clone/src/models/users/user_model.dart';

class CommentModel {
  final String id;
  final String text;
  final UserModel user;
  int likesNumber;
  bool liked;

  CommentModel({
    required this.id,
    required this.user,
    required this.text,
    required this.likesNumber,
    required this.liked,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      text: json['text'] as String,
      likesNumber: json['likes_number'] as int,
      liked: json['liked'] as bool,
    );
  }
}
