part of boxy;

class SvgUtils {
  
  /**
   * Apply the current SVG transforms matrix of the element (ex : translate) to the given point.
   **/
  static Point coordinateTransform(var point, SvgElement element) {
    return point.matrixTransform(element.getCtm());
  }
  
  
  static bool intersect(Widget widget, num x, num y) {
    Rect rect = widget.element.getBBox();
    return (x > rect.x) && (x < rect.x + rect.width) && (y > rect.y)  && (y < rect.y + rect.height);
  }
}