import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentForm extends StatelessWidget {
  const CommentForm({
    Key? key,
    required this.formKey,
    required this.sendComment,
    required this.saveComment,
    required this.controller,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final Function() sendComment;
  final Function(String? value) saveComment;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                onSaved: saveComment,
                controller: controller,
                onFieldSubmitted: (v) {
                  saveComment(v);
                  sendComment();
                },
                decoration: const InputDecoration(
                  labelText: 'Add Comment...',
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: sendComment,
              icon: SvgPicture.asset('assets/icons/post/send.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
