import 'package:instagram_clone/src/models/file_model.dart';

class CommentModel {
  final String id;
  final String username;
  final String text;
  final FileModel userAvatar;
  int likesNumber;
  bool liked;

  CommentModel({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.text,
    required this.likesNumber,
    required this.liked,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      username: json['username'] as String,
      userAvatar: FileModel.fromJson(json['user_avatar'] as Map<String, dynamic>),
      text: json['text'] as String,
      likesNumber: json['likes_number'] as int,
      liked: json['liked'] as bool,
    );
  }
}
