import 'package:flutter/material.dart';
import 'dart:math';

class WordTile extends StatelessWidget {
  final String letter;
  final Color color;
  final bool flipping;

  const WordTile({
    super.key,
    required this.letter,
    required this.color,
    required this.flipping,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      transform: Matrix4.rotationY(flipping ? pi / 2 : 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Transform(
        transform: Matrix4.identity(),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
