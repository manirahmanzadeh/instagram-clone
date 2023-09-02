import '../../../models/file_model.dart';
import '../../../models/post/post_model.dart';

class ExplorePostModel extends PostModel {
  final FileModel cover;

  ExplorePostModel({
    required super.id,
    required super.user,
    required super.likesNumber,
    required super.peopleLiked,
    required super.caption,
    required super.commentsNumber,
    required super.isSlide,
    required super.medias,
    required super.liked,
    required super.saved,
    required super.aspectRatio,
    required this.cover,
  });

  factory ExplorePostModel.fromJson(Map<String, dynamic> json) {
    PostModel postModel = PostModel.fromJson(json);
    return ExplorePostModel(
      id: postModel.id,
      user: postModel.user,
      likesNumber: postModel.likesNumber,
      peopleLiked: postModel.peopleLiked,
      caption: postModel.caption,
      commentsNumber: postModel.commentsNumber,
      isSlide: postModel.isSlide,
      medias: postModel.medias,
      liked: postModel.liked,
      saved: postModel.saved,
      aspectRatio: postModel.aspectRatio,
      cover: FileModel.fromJson(json['cover']),
    );
  }
}
