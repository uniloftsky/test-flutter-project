import 'dart:math';
import 'dart:ui';

class ColorGenerator {
  static final random = new Random();

  static Color generateColor() {
    return Color.fromRGBO(
        random.nextInt(255), random.nextInt(255), random.nextInt(255), 1);
  }
}
