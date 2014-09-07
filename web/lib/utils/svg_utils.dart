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

    var matrix = null;
    try {
      matrix = svgEl.getTransformToElement(element).inverse();
    } on DomException catch (e) {
      // Matrix not invertable
      return point;
    }

    return point.matrixTransform(matrix);
  }

  static svg.Point coordinateGlobal2Local(num x, num y, svg.SvgElement element) {
    svg.SvgSvgElement svgEl = element.ownerSvgElement;

    var point = svgEl.createSvgPoint();
    point.x = x;
    point.y = y;

    var matrix = null;
    try {
      matrix = element.ownerSvgElement.getScreenCtm().inverse();
      point = point.matrixTransform(matrix);
    } on DomException catch (e) {
      // Matrix not invertable
    }

    return SvgUtils.coordinateTransform(point.x, point.y, element);
  }

  static bool includeElement(svg.SvgElement parent, svg.SvgElement checked) {
    svg.Rect rect1 = SvgUtils.getBBox(parent);
    svg.Rect rect2 = SvgUtils.getBBox(checked);

    return (rect1.x < rect2.x && rect2.x + rect2.width < rect1.x + rect1.width && rect1.y < rect2.y && rect2.y + rect2.height < rect1.y + rect1.height);
  }

  static bool intersectElements(svg.SvgElement element1, svg.SvgElement element2) {
    svg.Rect rect1 = SvgUtils.getBBox(element1);
    svg.Rect rect2 = SvgUtils.getBBox(element2);

    return !(rect1.x + rect1.width < rect2.x || rect2.x + rect2.width < rect1.x || rect1.y + rect1.height < rect2.y || rect2.y + rect2.height < rect1.y);
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

  static svg.Rect getBBoxElements(List<svg.SvgElement> elements) {
    svg.Rect r = null;

    for (svg.SvgElement e in elements) {
      svg.Rect ebb = SvgUtils.getBBox(e);
      if (r == null) {
        r = ebb;
      } else {
        if (ebb.x + ebb.width <= r.x + r.width) {
          r.width = r.x + r.width - ebb.x;
        } else {
          r.width = ebb.x + ebb.width - r.x;
        }
        if (ebb.y + ebb.height <= r.y + r.height) {
          r.height = r.y + r.height - ebb.y;
        } else {
          r.height = ebb.y + ebb.height - r.y;
        }
        if (ebb.x < r.x) {
          r.x = ebb.x;
        }
        if (ebb.y < r.y) {
          r.y = ebb.y;
        }
      }
    }

    return r;
  }

}
