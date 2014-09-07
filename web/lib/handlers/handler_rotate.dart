part of boxy;

class RotateHandler extends WidgetHandler {

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "green";

  RotateHandler(String selectorName, List<Widget> widgets) : super.forWidgets(widgets) {

    this.handlerName = selectorName;

    element = new svg.CircleElement();

    element.attributes = {
      "id": selectorName,
      "r": "${_SIZE / 2}",
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "transparent"
    };

  }

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, 0);

    this.x = widget.x + (widget.width / 2);
    this.y = widget.y - 20;

    // Subscribe to selected widgets events
    subscribedEvents.add(widget.onResize.listen((e) => scale(e.dx, e.dy)));
    subscribedEvents.add(widget.onTranslate.listen((e) => translate(e.dx, e.dy)));
    subscribedEvents.add(widget.onUpdate.listen((e) => updateCoordinates()));

  }

  void onDrag(HandlerDragEvent e) {
    // compute degree
    num circleRay;
    if (widget.width > widget.height) {
      circleRay = widget.width / 2;
    } else {
      circleRay = widget.height / 2;
    }

    num cx = widget.cx;
    num cy = widget.cy;

    num angleRad = math.acos((x + e.dx - cx) / circleRay);

    num circleX = cx + circleRay * math.cos(angleRad);
    num circleY = cy + circleRay * math.cos(angleRad);

    num angle = 90 - MathUtils.radToDeg(angleRad);

    element.attributes["transform"] = "translate(${circleX - widget.x - (widget.width / 2)}, ${circleY  - widget.y - (widget.height / 2)})";

    //selector._selectorGroup.attributes["transform"] = "rotate($angle,${cx}, ${cy})";

    //selector.selectedWidget.rotate(rotationAngle);
  }

  void onDragEnd(HandlerDragEvent e) {
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
