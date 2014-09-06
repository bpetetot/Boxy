part of boxy;

class GripResize extends SelectorItem {

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 1.0;
  static final String _COLOR = "red";
  static final String _CURSOR = "nwse-resize";

  GripResize(String selectorName, Widget selectedWidget) : super([selectedWidget]) {

    this.selectorName = selectorName;

    element = new svg.CircleElement();

    element.attributes = {
      "id": selectorName,
      "r": "${_SIZE / 2}",
      "cursor": _CURSOR,
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "red"
    };

    svg.Rect widgetBBox = SvgUtils.getBBox(widget.element);
    this.x = widgetBBox.x + widgetBBox.width + 3;
    this.y = widgetBBox.y + widgetBBox.height + 3;

  }

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, 0);

    // Subscribe to selected widgets events
    subscribedEvents.add(widget.onResize.listen((e) => translate(e.dx, e.dy)));
    subscribedEvents.add(widget.onTranslate.listen((e) => translate(e.dx, e.dy)));
    subscribedEvents.add(widget.onUpdate.listen((e) => updateCoordinates()));

  }

  num lastDx = 0;
  num lastDy = 0;

  void onDrag(SelectorDragEvent e) {

    // Manage grip moving when it's out of widget top and left border
    var topLeftPt = SvgUtils.coordinateTransform(widget.x, widget.y, widget.element);
    var bottomRightPt = SvgUtils.coordinateTransform(widget.x + widget.width, widget.y + widget.height, widget.element);
    num width = bottomRightPt.x - topLeftPt.x;
    num height = bottomRightPt.y - topLeftPt.y;

    if (e.mouse.offset.x > widget.x + 10 && e.mouse.offset.y > widget.y + 10) {

      num newDx = e.dx;
      num newDy = e.dy;

      if (e.dx < lastDx && width <= 10) {
        newDx = lastDx;
      }
      if (e.dy < lastDy && height <= 10) {
        newDy = lastDy;
      }

      widget.scale(newDx, newDy);
      onResize.add(new ResizeEvent(newDx, newDy));

      this.lastDx = newDx;
      this.lastDy = newDy;
    }

  }

  void onDragEnd(SelectorDragEvent e) {
    widget.updateCoordinates();
  }

  void updateCoordinates() {
    super.updateCoordinates();
    this.lastDx = 0;
    this.lastDy = 0;
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
