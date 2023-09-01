import 'package:instagram_clone/src/models/media_model.dart';

class StoryModel {
  final String id;
  final MediaModel media;
  final bool seen;

  StoryModel({
    required this.id,
    required this.media,
    required this.seen,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'] as String,
      media: MediaModel.fromJson(json['media'] as Map<String, dynamic>),
      seen: json['seen'] as bool,
    );
  }
}
