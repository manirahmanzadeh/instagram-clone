import 'package:instagram_clone/src/models/file_model.dart';

import '../story/story_model.dart';

class UserModel {
  final String id;
  final String username;
  final String name;
  final FileModel userAvatar;
  final List<StoryModel> stories;
  get hasStory => stories.isNotEmpty;
  get newStory => stories.any((element) => !element.seen);

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.userAvatar,
    required this.stories,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      userAvatar:
          FileModel.fromJson(json['user_avatar'] as Map<String, dynamic>),
      stories: json['stories'] == null
          ? []
          : (json['stories'] as List)
              .map(
                (e) => StoryModel.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
