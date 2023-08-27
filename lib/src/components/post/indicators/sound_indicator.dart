import 'package:flutter/material.dart';

class SoundIndicator extends StatelessWidget {
  const SoundIndicator({Key? key, required this.soundOn}) : super(key: key);
  final bool soundOn;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black54,
      ),
      child: Icon(
        soundOn ? Icons.volume_up : Icons.volume_off,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
