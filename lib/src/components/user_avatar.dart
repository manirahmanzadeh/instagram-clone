import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

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
            padding: EdgeInsets.all(size * 7 /100),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/mock/feed/images/me.png'),
              radius: double.maxFinite,
            ),
          )
        ],
      ),
    );
  }
}
