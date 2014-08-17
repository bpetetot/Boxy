part of boxy;

class Rubber extends SelectorItem {

  static final double _LINE_WIDTH = 1.5;
  static final String _COLOR = "blue";
  static final String _CURSOR = "move";

  Rubber(String selectorName, Widget selectedWidget) : super(selectedWidget) {

    this.selectorName = selectorName;

    element = new RectElement();

    element.attributes = {
      "id": selectorName,
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "stroke-dasharray": "10 5",
      "cursor": _CURSOR,
      "fill": "transparent",
      "vector-effect": "non-scaling-stroke",
      "shape-rendering": "auto"
    };

    x = selectedWidget.x - 3;
    y = selectedWidget.y - 3;
    width = selectedWidget.width + 6;
    height = selectedWidget.height + 6;

  }

  void attach(SvgElement parent) {
    super.attach(parent);

    // Manage listeners
    // FIXME Add a subscription list into widget to automatically discards on dettach
    this.addTranslateListener((x, y) => selectedWidget.translate(x, y));
    selectedWidget.addResizeListener((x, y) => this.scale(x, y));
    selectedWidget.addUpdateListener(() => this.updateCoordinates());

  }

  void onDrag(num dx, num dy) {
    this.translate(dx, dy);
  }

  void onDragEnd(num dx, num dy) {
    selectedWidget.updateCoordinates();
  }

  double get x => double.parse(element.attributes["x"]);

  double get cx => x + (width / 2);

  double get y => double.parse(element.attributes["y"]);

  double get cy => y + (height / 2);

  double get width => double.parse(element.attributes["width"]);

  double get height => double.parse(element.attributes["height"]);

  set x(double x) => element.attributes["x"] = "$x";

  set y(double y) => element.attributes["y"] = "$y";

  set width(double width) => element.attributes["width"] = "$width";

  set height(double height) => element.attributes["height"] = "$height";

}
