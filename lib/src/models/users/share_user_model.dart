import 'package:instagram_clone/src/models/file_model.dart';

class ShareUserModel {
  final String id;
  final String username;
  final String name;
  final FileModel userAvatar;

  ShareUserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.userAvatar,
  });

  factory ShareUserModel.fromJson(Map<String, dynamic> json) {
    return ShareUserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      userAvatar:
      FileModel.fromJson(json['user_avatar'] as Map<String, dynamic>),
    );
  }
}
