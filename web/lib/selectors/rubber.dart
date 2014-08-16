part of boxy;

class Rubber extends SelectorItem {

  Selector selector;

  static final double _LINE_WIDTH = 0.2;
  static final String _COLOR = "blue";
  static final String _CURSOR = "move";

  Rubber(String selectorName) {

    this.selectorName = selectorName;

    element = new RectElement();

    element.attributes = {
      "id": selectorName,
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "cursor": _CURSOR,
      "fill": "transparent",
      "vector-effect": "non-scaling-stroke",
      "shape-rendering": "auto"
    };

  }

  void onDrag(num dx, num dy) {
    // Manage selector elements
    this.translate(dx, dy);
    selector._gripResize.translate(dx, dy);
    selector._gripRotate.translate(dx, dy);

    // Manage widget
    selector.selectedWidget.translate(dx, dy);
  }

  void onDragEnd(num dx, num dy) {

    selector.updateSelectorsCoordinates();
    selector.selectedWidget.updateCoordinates();

  }
  
  void translate(num dx, num dy) {
      element.attributes["transform"] = "translate(${dx}, ${dy})";
   
  }


  void scale(num dx, num dy) {
    // compute scale and translate ratio
    num ratioX = ((width + dx) / width);
    num ratioY = ((height + dy) / height);

    num translateX = -x * (ratioX - 1);
    num translateY = -y * (ratioY - 1);

    selector._rubber.element.attributes["transform"] = "translate(${translateX},${translateY}) scale(${ratioX}, ${ratioY})";
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
