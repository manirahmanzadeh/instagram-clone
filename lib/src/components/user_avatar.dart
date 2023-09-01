import 'package:flutter/material.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';
import 'package:vrouter/vrouter.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    Key? key,
    required this.size,
    required this.user,
    this.showStoryIndicator = true,
  }) : super(key: key);
  final double size;
  final UserModel user;
  final bool showStoryIndicator;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  bool openingStory = false;

  Future<void> openStories() async {
    setState(() {
      openingStory = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      openingStory = false;
    });
    context.vRouter.to('stories/${widget.user.id}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: openStories,
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.user.hasStory && widget.showStoryIndicator)
              SizedBox(
                height: widget.size,
                width: widget.size,
                child: CircularProgressIndicator(
                  value: openingStory ? null : 1,
                  color: widget.user.newStory ? Colors.red.withOpacity(0.7) : Colors.black26,
                  strokeWidth: 3,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(widget.size * 5 / 100),
              child: CircleAvatar(
                backgroundImage: AssetImage(widget.user.userAvatar.file),
                radius: double.maxFinite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
