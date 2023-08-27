import '../file_model.dart';

class MediaModel {
  final FileModel file;
  final FileType fileType;

  const MediaModel({required this.file, required this.fileType});

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      file: FileModel.fromJson(json['file'] as Map<String, dynamic>),
      fileType: fileTypeParser(json['type'] as String),
    );
  }

  static FileType fileTypeParser(String type) {
    switch (type) {
      case 'image':
        return FileType.image;
      case 'video':
        return FileType.video;
    }
    return FileType.image;
  }
}

enum FileType {
  image,
  video,
}
