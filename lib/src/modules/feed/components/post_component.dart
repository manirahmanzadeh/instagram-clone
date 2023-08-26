import 'package:flutter/material.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
        border: Border.symmetric(vertical: BorderSide(color: Color(0xFFE0E0E0))),

      ),
    );
  }
}
