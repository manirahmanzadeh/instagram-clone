import 'package:instagram_clone/src/models/users/user_model.dart';
import '../media_model.dart';

class PostModel {
  final String id;
  final UserModel user;
  final int likesNumber;
  final List<String> peopleLiked;
  final String caption;
  final int commentsNumber;
  final bool isSlide;
  final double aspectRatio;
  bool liked;
  bool saved;
  final List<MediaModel> medias;

  PostModel({
    required this.id,
    required this.user,
    required this.likesNumber,
    required this.peopleLiked,
    required this.caption,
    required this.commentsNumber,
    required this.isSlide,
    required this.medias,
    required this.liked,
    required this.saved,
    required this.aspectRatio,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      user:
          UserModel.fromJson(json['user'] as Map<String, dynamic>),
      likesNumber: json['likes_number'] as int,
      peopleLiked:
          (json['people_liked'] as List).map((e) => e as String).toList(),
      caption: json['caption'] as String,
      commentsNumber: json['comments_number'] as int,
      isSlide: json['is_slide'] as bool,
      liked: json['liked'] as bool,
      saved: json['saved'] as bool,
      aspectRatio: json['aspect_ratio'] as double,
      medias: (json['medias'] as List)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

}

