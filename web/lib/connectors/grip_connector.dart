part of boxy;

class GripConnector extends Widget {

  static final double _SIZE = 5.0;
  static final double _LINE_WIDTH = 1.0;
  static final String _COLOR = "blue";
  static final String _CURSOR = "crosshair";

  Widget selectedWidget;

  GripConnector() {

    element = new svg.CircleElement();

    element.attributes = {
      "cx": "0",
      "cy": "0",
      "r": "${_SIZE / 2}",
      "cursor": _CURSOR,
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": _COLOR,
      "display": "none"
    };

  }

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, 0);
  }

  void attachWidget(Widget selectedWidget) {
    this.selectedWidget = selectedWidget;
    
    // Subscribe to selected widgets events
    subscribedEvents.add(selectedWidget.element.onMouseMove.listen((e) => setGripPosition(e.offset.x + 0.0, e.offset.y + 0.0)));
    subscribedEvents.add(selectedWidget.element.onMouseOut.listen((e) => this.show()));

  }

  void dettachCurrentWidget() {
    // remove the widget
    this.selectedWidget = null;
  }

  void setGripPosition(double x, double y) {
    this.show();

    num thresholdX = selectedWidget.width * 0.1;
    num thresholdY = selectedWidget.height * 0.1;

    // Set X
    if (x >= selectedWidget.x + selectedWidget.width - thresholdX) {
      this.x = selectedWidget.x + selectedWidget.width - ray;
    } else if (x <= selectedWidget.x + thresholdX) {
      this.x = selectedWidget.x - ray;
    } else {
      this.x = x - ray;
    }

    // Set Y
    if (y >= selectedWidget.y + selectedWidget.height - thresholdY) {
      this.y = selectedWidget.y + selectedWidget.height - ray;
    } else if (y <= selectedWidget.y + thresholdY) {
      this.y = selectedWidget.y - ray;
    } else {
      this.y = y - ray;
    }
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
