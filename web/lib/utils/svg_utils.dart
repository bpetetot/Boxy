part of boxy;

class SvgUtils {
  
  /**
   * Apply the current SVG transforms matrix of the element (ex : translate) to the given point.
   **/
  static svg.Point coordinateTransform(svg.Point point, svg.SvgElement element) {
    return point.matrixTransform(element.ownerSvgElement.getTransformToElement(element).inverse());
  }
  
  
  static bool intersect(Widget widget, num x, num y) {
    Rectangle rect = widget.element.getBoundingClientRect();
    
    svg.Point topLeft = widget.parentSvg.createSvgPoint();
    topLeft.x = rect.left;
    topLeft.y = rect.top;
    topLeft = SvgUtils.coordinateTransform(topLeft, widget.element);
    
    svg.Point bottomRight = widget.parentSvg.createSvgPoint();
    bottomRight.x = rect.right;
    bottomRight.y = rect.bottom;
    bottomRight = SvgUtils.coordinateTransform(bottomRight, widget.element);
    
    return (x > topLeft.x) && (x < bottomRight.x) && (y > topLeft.y)  && (y < bottomRight.y);
  }
}