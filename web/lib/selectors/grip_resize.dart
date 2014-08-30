part of boxy;

class GripResize extends SelectorItem {

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 1.0;
  static final String _COLOR = "red";
  static final String _CURSOR = "nwse-resize";

  GripResize(String selectorName, Widget selectedWidget) : super(selectedWidget) {

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

    this.x = selectedWidget.x + selectedWidget.width + 3;
    this.y = selectedWidget.y + selectedWidget.height + 3;

  }

  void attach(svg.SvgElement parent) {
    super.attach(parent);

    // Rubber listener
    subscribedEvents.add(this.onResize.listen((e) => selectedWidget.scale(e.dx, e.dy)));

    // Subscribe to selected widgets events
    subscribedEvents.add(selectedWidget.onTranslate.listen((e) => translate(e.dx, e.dy)));
    subscribedEvents.add(selectedWidget.onUpdate.listen((e) => updateCoordinates()));

  }

  void onDrag(num dx, num dy) {
    // Manage selector elements
    this.translate(dx, dy);
    // Notify listeners
    onResize.add(new ResizeEvent(dx, dy));
  }

  void onDragEnd(num dx, num dy) {
    selectedWidget.updateCoordinates();
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
