part of boxy;

class GripResize extends SelectorItem {

  Selector selector;

  static final double _SIZE = 10.0;
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "red";

  GripResize() {
    element = new CircleElement();

    element.attributes = {
      "r": "${_SIZE / 2}",
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "transparent"
    };
  } 

  void onDrag(num dx, num dy) {
    // compute scale and translate ratio
    num ratioX = ((selector._rubber.width + dx) / selector._rubber.width);
    num ratioY = ((selector._rubber.height + dy) / selector._rubber.height);

    num translateX = -selector._rubber.x * (ratioX - 1);
    num translateY = -selector._rubber.y * (ratioY - 1);
    
    // Manage selector elements
    element.attributes["transform"] = "translate(${dx}, ${dy})";
    selector._rubber.element.attributes["transform"] = "translate(${translateX},${translateY}) scale(${ratioX}, ${ratioY})";
    selector._gripRotate.element.attributes["transform"] = "translate(${dx / 2}, 0)";
    
    selector.selectedWidget.scale(dx, dy);
  }

  void onDragEnd(num dx, num dy) {
    selector.updateSelectorsCoordinates();
    selector.selectedWidget.updateCoordinates();
    element.attributes["transform"] = "";
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
