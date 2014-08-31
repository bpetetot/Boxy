part of boxy;

class SvgUtils {

  /**
   * Apply the current SVG transforms matrix of the element (ex : translate) to the given point.
   **/
  static svg.Point coordinateTransform(num x, num y, svg.SvgElement element) {
    svg.SvgSvgElement svgEl = element.ownerSvgElement;

    var point = svgEl.createSvgPoint();
    point.x = x;
    point.y = y;

    return point.matrixTransform(svgEl.getTransformToElement(element).inverse());
  }

  static svg.Point coordinateGlobal2Local(num x, num y, svg.SvgElement element) {
    svg.SvgSvgElement svgEl = element.ownerSvgElement;

    var point = svgEl.createSvgPoint();
    point.x = x;
    point.y = y;
    point = point.matrixTransform(element.ownerSvgElement.getScreenCtm().inverse());

    return SvgUtils.coordinateTransform(point.x, point.y, element);
  }


  static bool intersect(num x, num y, svg.SvgElement element) {
    Rectangle rect = element.getBoundingClientRect();
    svg.Point topLeft = SvgUtils.coordinateGlobal2Local(rect.left, rect.top, element);
    svg.Point bottomRight = SvgUtils.coordinateGlobal2Local(rect.right, rect.bottom, element);

    return (x > topLeft.x) && (x < bottomRight.x) && (y > topLeft.y) && (y < bottomRight.y);
  }


  static svg.Rect getBBox(svg.SvgElement element) {
    Rectangle rect = element.getBoundingClientRect();
    svg.Point topLeft = SvgUtils.coordinateGlobal2Local(rect.left, rect.top, element);
    svg.Point bottomRight = SvgUtils.coordinateGlobal2Local(rect.right, rect.bottom, element);

    svg.Rect r = element.ownerSvgElement.createSvgRect();
    r.x = topLeft.x;
    r.y = topLeft.y;
    r.width = bottomRight.x - topLeft.x;
    r.height = bottomRight.y - topLeft.y;
    
    return r;
  }

}
