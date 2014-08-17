part of boxy;

class GripResize extends SelectorItem {

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "red";

  GripResize(String selectorName, Widget selectedWidget) : super(selectedWidget) {

    this.selectorName = selectorName;

    element = new CircleElement();

    element.attributes = {
      "id": selectorName,
      "r": "${_SIZE / 2}",
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "transparent"
    };

    this.x = selectedWidget.x + selectedWidget.width + 2;
    this.y = selectedWidget.y + selectedWidget.height + 2;

  }

  void attach(SvgElement parent) {
    super.attach(parent);

    // Manage listeners
    // FIXME Add a subscription list into widget to automatically discards on dettach
    this.addResizeListener((x, y) => selectedWidget.scale(x, y));
    selectedWidget.addTranslateListener((x, y) => this.translate(x, y));
    selectedWidget.addUpdateListener(() => this.updateCoordinates());

  }

  void onDrag(num dx, num dy) {

    // Manage selector elements
    this.translate(dx, dy);

    for (dynamic listener in resizeListeners) {
      listener(dx, dy);
    }

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
