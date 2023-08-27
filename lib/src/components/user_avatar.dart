import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/file_model.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.size,
    required this.image,
  }) : super(key: key);
  final double size;
  final FileModel image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/feed/ellipse.svg',
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          Padding(
            padding: EdgeInsets.all(size * 7 / 100),
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
