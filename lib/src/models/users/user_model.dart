import 'package:instagram_clone/src/models/file_model.dart';

class UserModel {
  final String id;
  final String username;
  final String name;
  final FileModel userAvatar;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.userAvatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      userAvatar:
      FileModel.fromJson(json['user_avatar'] as Map<String, dynamic>),
    );
  }
}
