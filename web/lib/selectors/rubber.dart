part of boxy;

class Rubber extends SelectorItem {

  Selector selector;
  
  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "blue";
  static final String _CURSOR = "move";

  Rubber() {
    element = new RectElement();

    element.attributes = {
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "cursor": _CURSOR,
      "fill": "transparent",
      "vector-effect" : "non-scaling-stroke",
      "shape-rendering" : "auto"
    };

  }

  void onDrag(num dx, num dy) {
    // Manage selector elements
    element.attributes["transform"] = "translate(${dx}, ${dy})";
    selector._gripResize.element.attributes["transform"] = "translate(${dx}, ${dy})";
    selector._gripRotate.element.attributes["transform"] = "translate(${dx}, ${dy})";
    
    // Manage widget
    selector.selectedWidget.translate(dx, dy);
  }
  
  void onDragEnd(num dx, num dy) {
    
    selector.updateSelectorsCoordinates();
    selector.selectedWidget.updateCoordinates();
    
  }

  double get x => double.parse(element.attributes["x"]);

  double get y => double.parse(element.attributes["y"]);

  double get width => double.parse(element.attributes["width"]);

  double get height => double.parse(element.attributes["height"]);

  set x(double x) => element.attributes["x"] = "$x";

  set y(double y) => element.attributes["y"] = "$y";

  set width(double width) => element.attributes["width"] = "$width";

  set height(double height) => element.attributes["height"] = "$height";

}
