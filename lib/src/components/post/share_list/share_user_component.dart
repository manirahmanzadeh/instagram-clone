import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/user_avatar.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';

class ShareUserComponent extends StatelessWidget {
  const ShareUserComponent({
    Key? key,
    required this.user,
    required this.addToShare,
    required this.selected,
  }) : super(key: key);
  final UserModel user;
  final bool selected;
  final Function() addToShare;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(
        size: 40,
        user: user,
      ),
      onTap: addToShare,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(user.name),
          selected
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                )
              : const Icon(Icons.circle_outlined)
        ],
      ),
      subtitle: Text(user.username),
    );
  }
}
