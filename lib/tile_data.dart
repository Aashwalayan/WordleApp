import 'package:flutter/material.dart';

class TileData {
  String letter;
  Color color;
  bool flipping;

  TileData(this.letter, this.color, {this.flipping = false});
}
