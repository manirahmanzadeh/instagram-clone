import 'package:instagram_clone/src/models/file_model.dart';

import 'media_model.dart';

class PostModel {
  final String id;
  final String username;
  final FileModel userAvatar;
  final int likesNumber;
  final List<String> peopleLiked;
  final String caption;
  final int commentsNumber;
  final bool isSlide;
  bool liked;
  final List<MediaModel> medias;

  PostModel({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.likesNumber,
    required this.peopleLiked,
    required this.caption,
    required this.commentsNumber,
    required this.isSlide,
    required this.medias,
    required this.liked,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      username: json['username'] as String,
      userAvatar:
          FileModel.fromJson(json['user_avatar'] as Map<String, dynamic>),
      likesNumber: json['likes_number'] as int,
      peopleLiked:
          (json['people_liked'] as List).map((e) => e as String).toList(),
      caption: json['caption'] as String,
      commentsNumber: json['comments_number'] as int,
      isSlide: json['is_slide'] as bool,
      liked: json['liked'] as bool,
      medias: (json['medias'] as List)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
