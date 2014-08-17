part of boxy;

class SvgUtils {
  
  /**
   * Apply the current SVG transforms matrix of the element (ex : translate) to the given point.
   **/
  static Point coordinateTransform(var point, SvgElement element) {
    return point.matrixTransform(element.getCtm());
  }
  
}