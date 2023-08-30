import 'dart:ui';

class ColorsRes {
  ColorsRes._shared();
  static final ColorsRes _instance = ColorsRes._shared();
  factory ColorsRes() => _instance;

  static const Color darkBackground = Color(0xFF2a2b2e);
  static const Color light = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFd80000);
  static const Color lightBlue = Color(0xFF027eb5);
  static const Color darkgrey = Color(0xFF707070);
  static const Color lightGrey = Color(0xFF667781);
  static const Color green = Color(0xFF0aa31e);
  static const Color yellow = Color(0xFFF9f900);
  static const Color lightBackground = Color(0x58797777);
  static const Color greyBackground = Color(0xFF202c33);
}
