part of boxy;

class GripRotate extends SelectorItem {

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "green";

  GripRotate(String selectorName, Widget selectedWidget) : super(selectedWidget) {

    this.selectorName = selectorName;

    element = new CircleElement();

    element.attributes = {
      "id": selectorName,
      "r": "${_SIZE / 2}",
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "transparent"
    };

    this.x = selectedWidget.x + (selectedWidget.width / 2);
    this.y = selectedWidget.y - 20;

  }

  void attach(SvgElement parent) {
    super.attach(parent);

    // Subscribe to selected widgets events
    subscribedEvents.add(selectedWidget.onResize.listen((e) => scale(e.dx, e.dy)));
    subscribedEvents.add(selectedWidget.onTranslate.listen((e) => translate(e.dx, e.dy)));
    subscribedEvents.add(selectedWidget.onUpdate.listen((e) => updateCoordinates()));

  }

  void onDrag(num dx, num dy) {
    // compute degree
    num circleRay;
    if (selectedWidget.width > selectedWidget.height) {
      circleRay = selectedWidget.width / 2;
    } else {
      circleRay = selectedWidget.height / 2;
    }

    num cx = selectedWidget.cx;
    num cy = selectedWidget.cy;

    num angleRad = acos((x + dx - cx) / circleRay);

    num circleX = cx + circleRay * cos(angleRad);
    num circleY = cy + circleRay * cos(angleRad);

    num angle = 90 - MathUtils.radToDeg(angleRad);

    element.attributes["transform"] = "translate(${circleX - selectedWidget.x - (selectedWidget.width / 2)}, ${circleY  - selectedWidget.y - (selectedWidget.height / 2)})";

    //selector._selectorGroup.attributes["transform"] = "rotate($angle,${cx}, ${cy})";

    //selector.selectedWidget.rotate(rotationAngle);
  }

  void onDragEnd(num dx, num dy) {
    //selector.updateSelectorsCoordinates();
    //selector.selectedWidget.updateCoordinates();
    //element.attributes["transform"] = "";
  }

  void scale(num dx, num dy) {
    this.translate(dx / 2, 0);
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
