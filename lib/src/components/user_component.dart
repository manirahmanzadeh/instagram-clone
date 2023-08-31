import 'package:flutter/material.dart';
import 'package:instagram_clone/src/components/user_avatar.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';

class UserComponent extends StatelessWidget {
  const UserComponent({
    Key? key,
    required this.userModel,
  }) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(size: 40, image: userModel.userAvatar),
      title: Text(userModel.name),
      subtitle: Text(userModel.username),
    );
  }
}
