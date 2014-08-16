part of boxy;

class GripResize extends SelectorItem {

  Selector selector;

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "red";

  GripResize(String selectorName) {

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

    // Manage selector elements
    this.translate(dx, dy);

    selector._gripRotate.translate(dx / 2, 0);

    selector._rubber.scale(dx, dy);

    selector.selectedWidget.scale(dx, dy);
  }

  void onDragEnd(num dx, num dy) {
    selector.updateSelectorsCoordinates();
    selector.selectedWidget.updateCoordinates();
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
