import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/user_avatar.dart';
import 'package:instagram_clone/src/models/users/share_user_model.dart';

class ShareUserComponent extends StatelessWidget {
  const ShareUserComponent({
    Key? key,
    required this.userModel,
    required this.addToShare,
    required this.selected,
  }) : super(key: key);
  final ShareUserModel userModel;
  final bool selected;
  final Function() addToShare;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(size: 40, image: userModel.userAvatar),
      onTap: addToShare,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(userModel.name),
          selected ? Icon(Icons.check_circle, color: Colors.blue,)
              : Icon(Icons.circle_outlined)
        ],
      ),
      subtitle: Text(userModel.username),
    );
  }
}
