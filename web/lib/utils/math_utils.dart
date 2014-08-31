part of boxy;

class MathUtils {
  
  static num degTorad(num deg) => deg * (math.PI / 180.0);
  
  static num radToDeg(num rad) => rad * (180 / math.PI);
  
  static bool isNumeric(String value) {
    try {
      int numeric = num.parse(value);

    } on TypeError catch (e) {
      return true;
    } on FormatException catch (e) {
      return false;
    }
    return true;
  }
  
}