import 'package:flutter/material.dart';

class SingleStoryProgressLine extends StatelessWidget {
  const SingleStoryProgressLine({Key? key, required this.value})
      : super(key: key);
  final double value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 3,
              color: const Color(0xFFB9B7BA),
            ),
            AnimatedSize(
              duration: const Duration(seconds: 1),
              child: SizedBox(
                width: value,
                child: Container(
                  height: 3,
                  color: Colors.white,
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
