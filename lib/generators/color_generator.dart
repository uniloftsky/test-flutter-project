import 'dart:math';
import 'dart:ui';

class ColorGenerator {
  static final random = new Random();

  static Color generateColor({
    required int red,
    required int green,
    required int blue,
  }) => Color(_generateColorHex(_getHexListFromInts(red: red, green: green, blue: blue)));

  static int _generateColorHex(List<String> colors) {
    final updatedHexes = colors.map((e) => e.length < 2 ? '0' + e : e);
    return int.parse('0xFF' + updatedHexes.reduce((value, element) => value + element));
  }

  static List<String> _getHexListFromInts({
    required int red,
    required int green,
    required int blue,
  }) => [red.toRadixString(16), green.toRadixString(16), blue.toRadixString(16)];
}
