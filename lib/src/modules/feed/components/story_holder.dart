import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StoryHolder extends StatelessWidget {
  const StoryHolder({
    Key? key,
    required this.isMe,
  }) : super(key: key);
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset('assets/icons/feed/ellipse.svg'),
              Container(
                height: 64,
                width: 64,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/mock/feed/images/me.png'),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          if (isMe)
            Transform.translate(
              offset: const Offset(1, 1),
              child: Container(
                height: 22,
                width: 22,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFF009BFB),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: SvgPicture.asset('assets/icons/feed/add_story.svg'),
              ),
            )
        ],
      ),
    );
  }
}
