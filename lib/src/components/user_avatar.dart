import 'package:flutter/material.dart';
import '../models/file_model.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.size,
    required this.image,
    required this.hasStory,
    required this.newStory,
  }) : super(key: key);
  final double size;
  final FileModel image;
  final bool hasStory;
  final bool newStory;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (hasStory)
            SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                value: 1,
                color: newStory ?Colors.red :Colors.black26,
                strokeWidth: 3,
              ),
            ),
          Padding(
            padding: EdgeInsets.all(size * 5 / 100),
            child: CircleAvatar(
              backgroundImage: AssetImage(image.file),
              radius: double.maxFinite,
            ),
          )
        ],
      ),
    );
  }
}
