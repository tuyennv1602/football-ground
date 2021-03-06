import 'package:flutter/material.dart';

const Color PRIMARY = Color(0xFF02AC2C);
const Color WHITE_OPACITY = Color(0xCCF9F9F9);
const Color LINE_COLOR = Color(0xFFE0E0E0);
const Color GREY_BACKGROUND = Color(0xFFFCFCFC);
const Color BLACK_TRANSPARENT = Color(0x66000000);
const Color RED_ERROR = Color(0xFFC01D04);
const Color GREEN_SUCCESS = Color(0xFF01A028);
const Color BLACK_TEXT = Colors.black87;
const Color SHADOW_GREEN = Color(0xFFA1FAB7);
const Color SHADOW_GREY = Color(0xFFE8E8E8);
const Color GREEN_TEXT = Color(0xFF03be31);
const Color LIGHT_GREEN = Color(0xFFF4FFF4);

const List<Color> BLACK_GRADIENT = [
  Color(0xCC000000),
  Color(0xBF000000),
  Color(0xB3000000),
  Color(0xA6000000),
  Color(0x99000000),
  Color(0x8C000000),
  Color(0x80000000),
  Color(0x73000000),
  Color(0x66000000),
  Color(0x59000000),
  Color(0x4D000000),
  Color(0x40000000),
  Color(0x33000000),
  Color(0x26000000),
  Color(0x1A000000),
  Color(0x0D000000),
  Color(0x00000000),
];

const List<Color> GREEN_GRADIENT = [Color(0xFF01A028), Color(0xFF057C21)];
const List<Color> GREEN_BUTTON = [Color(0xFF02DC37), PRIMARY];
const List<Color> GREY_BUTTON = [Color(0xFFD7D7D7), Color(0xFFA6A6A6)];
const List<Color> RED_BUTTON = [Color(0xFFE53935), Color(0xFFE11A15)];
const List<Color> PURPLE_GRADIENT = [Colors.deepPurpleAccent, Colors.deepPurpleAccent];
const List<Color> YELLOW_GRADIENT = [Colors.yellow, Colors.amber];
const List<Color> ORANGE_GRADIENT = [Colors.deepOrangeAccent, Colors.deepOrange];
const List<Color> PINK_GRADIENT = [Colors.pinkAccent, Colors.pink];
const List<Color> RED_GRADIENT = [Color(0xFFE53935), Color(0xFFE11A15)];

String getColorValue(String color) {
  return color.split('(0x')[1].split(')')[0];
}

Color parseColor(String code) {
  int value = int.parse(code, radix: 16);
  return Color(value);
}
