import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyStoryHolder extends StatelessWidget {
  const MyStoryHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 73,
      width: 73,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/feed/ellipse.svg',
                width: double.maxFinite,
                height: double.maxFinite,
              ),
              const Padding(
                padding: EdgeInsets.all(73 * 7 /100),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/mock/feed/images/me.png'),
                  radius: double.maxFinite,
                ),
              )
            ],
          ),
          Transform.translate(
              offset: const Offset(-5, -5),
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
          ),
        ],
      ),
    );
  }
}
