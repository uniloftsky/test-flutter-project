import 'dart:math';
import 'dart:ui';

/* Оскільки завданням стояло генерація RGB кольору, то було використано алгоритм, який
* перетворює вхідні дані червоного, зеленого і синього у готовий RGB колір.
*/
class ColorGenerator {
  static final random = new Random();

  /* Інша імплементація генератора кольору, що зав'язана на використанні вже готового метода Color.fromRGBO().
  * Мені здалось це у деякому сенсі легким, тому я вирішив створити певний не складний алгоритм, який генерує
  * колір в залежності від вхідних данних.
  */
  /*static Color generateColor({int red, int green, int blue}) {
    return Color.fromRGBO(red, green, blue, 1);
  }*/

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
