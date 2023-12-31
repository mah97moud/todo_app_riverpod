import 'dart:math';
import 'dart:ui';

class ColorsRes {
  ColorsRes._shared();
  static final ColorsRes _instance = ColorsRes._shared();
  factory ColorsRes() => _instance;

  static const Color darkBackground = Color(0xFF2a2b2e);
  static const Color light = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFd80000);
  static const Color lightBlue = Color(0xFF027eb5);
  static const Color darkGrey = Color(0xFF707070);
  static const Color lightGrey = Color(0xFF667781);
  static const Color green = Color(0xFF0aa31e);
  static const Color yellow = Color(0xFFF9f900);
  static const Color lightBackground = Color(0x58797777);
  static const Color greyBackground = Color(0xFF202c33);

  static const List<Color> colors = [
    Color(0xFFd80000),
    Color(0xFF027eb5),
    Color(0xFF0aa31e),
    Color(0xFFF9f900),
    Color.fromARGB(255, 225, 56, 248),
    Color.fromARGB(255, 11, 245, 190),
  ];

 static Color randomColor() {
    final random = Random();
    var colorLength = ColorsRes.colors.length;
    int randomIndex = random.nextInt(colorLength);
    var color = ColorsRes.colors[randomIndex];
    return color;
  }
}
