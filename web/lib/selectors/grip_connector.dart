part of boxy;

class GripConnector extends SelectorItem {

  static final double _SIZE = 5.0;
  static final double _LINE_WIDTH = 1.0;
  static final String _COLOR = "green";
  static final String _CURSOR = "nwse-resize";
  
  Rubber rubber;

  GripConnector(String selectorName, Rubber rubber, Widget selectedWidget) : super(selectedWidget) {

    this.selectorName = selectorName;
    this.rubber = rubber;

    element = new CircleElement();

    element.attributes = {
      "id": selectorName,
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

  void attach(SvgElement parent) {
    super.attach(parent);

    // Subscribe to selected widgets events
    listeners.add(rubber.element.onMouseMove.listen((e) => setConnectorPosition(e.offset.x + 0.0, e.offset.y + 0.0)));
    listeners.add(rubber.element.onMouseOut.listen((e) => element.attributes["display"] = "hide"));
    
    this.subscribedEvents.add(selectedWidget.onTranslate.listen((x, y) => translate(x, y)));
    this.subscribedEvents.add(selectedWidget.onResize.listen((x, y) => translate(x, y)));
    this.subscribedEvents.add(selectedWidget.onUpdate.listen(() => updateCoordinates()));
  }

  void setConnectorPosition(double x, double y) {
    element.attributes["display"] = "visible";
    
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

  void onDrag(num dx, num dy) {
    // DO NOTHING
  }

  void onDragEnd(num dx, num dy) {
    // DO NOTHING
  }

}
