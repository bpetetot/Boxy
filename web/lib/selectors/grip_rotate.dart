part of boxy;

class GripRotate extends SelectorItem {

  Selector selector;

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "green";

  GripRotate() {
    element = new CircleElement();

    element.attributes = {
      "r": "${_SIZE / 2}",
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "transparent"
    };
  }

  void onDrag(num dx, num dy) {
    //selectorGroup.attributes["transform"] = "rotate(${dx}, ${dy})";
    //selector.selectedWidget.onDrag(dx, dy);
  }

  void onDragEnd(num dx, num dy) {
    //selector.updateSelectorsCoordinates();
    //selector.selectedWidget.onDragEnd(dx, dy);
  }

  double get ray => double.parse(element.attributes["r"]);

  double get x => double.parse(element.attributes["cx"]) - ray;

  double get y => double.parse(element.attributes["cy"]) - ray;

  double get width => ray * 2;

  double get height => ray * 2;

  set x(double x) => element.attributes["cx"] = "${x + ray}";

  set y(double y) => element.attributes["cy"] = "${y + ray}";

  set width(double width) => element.attributes["r"] = "${_SIZE / 2}";

  set height(double height) => element.attributes["r"] = "${_SIZE / 2}";

}
