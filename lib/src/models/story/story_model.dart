import 'package:instagram_clone/src/models/file_model.dart';

class StoryModel {
  final String id;
  final String username;
  final FileModel userAvatar;
  final bool seen;

  StoryModel({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.seen,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] as String,
      username: json['username'] as String,
      userAvatar:
          FileModel.fromJson(json['user_avatar'] as Map<String, dynamic>),
      seen: json['seen'] as bool,
    );
  }
}
