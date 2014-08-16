part of boxy;

class GripRotate extends SelectorItem {

  Selector selector;

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "green";

  GripRotate(String selectorName) {

    this.selectorName = selectorName;

    element = new CircleElement();

    element.attributes = {
      "id": selectorName,
      "r": "${_SIZE / 2}",
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "transparent"
    };
  }

  void onDrag(num dx, num dy) {
    // compute degree
    num circleRay;
    if (selector._rubber.width > selector._rubber.height) {
      circleRay = selector._rubber.width / 2;
    } else {
      circleRay = selector._rubber.height / 2;
    }

    num cx = selector._rubber.cx;
    num cy = selector._rubber.cy;

    num angleRad = acos((x + dx - cx) / circleRay);

    num circleX = cx + circleRay * cos(angleRad);
    num circleY = cy + circleRay * cos(angleRad);

    num angle = 90 - MathUtils.radToDeg(angleRad);

    element.attributes["transform"] = "translate(${circleX - selector._rubber.x - (selector._rubber.width / 2)}, ${circleY  - selector._rubber.y - (selector._rubber.height / 2)})";

    selector._selectorGroup.attributes["transform"] = "rotate($angle,${cx}, ${cy})";

    //selector.selectedWidget.rotate(rotationAngle);
  }

  void onDragEnd(num dx, num dy) {
    //selector.updateSelectorsCoordinates();
    //selector.selectedWidget.updateCoordinates();
    //element.attributes["transform"] = "";
  }

  void translate(num dx, num dy) {
    element.attributes["transform"] = "translate(${dx}, ${dy})";
  }

  double get ray => double.parse(element.attributes["r"]);

  double get x => double.parse(element.attributes["cx"]) - ray;

  double get cx => x + ray;

  double get y => double.parse(element.attributes["cy"]) - ray;

  double get cy => y + ray;

  double get width => ray * 2;

  double get height => ray * 2;

  set x(double x) => element.attributes["cx"] = "${x + ray}";

  set y(double y) => element.attributes["cy"] = "${y + ray}";

  set width(double width) => element.attributes["r"] = "${_SIZE / 2}";

  set height(double height) => element.attributes["r"] = "${_SIZE / 2}";

}
