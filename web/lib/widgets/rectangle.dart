part of boxy;

class RectangleBoxy extends Widget {

  RectangleBoxy(double x, double y, double width, double height) {
    
    element = new SvgElement.tag("rect");
    element.attributes = {
      "x": "$x",
      "y": "$y",
      "width": "$width",
      "height": "$height",
      "stroke": "black",
      "fill": "white",
      "stroke-width": "1"
    };

  }

  double get x => double.parse(element.attributes["x"]);

  double get y => double.parse(element.attributes["y"]);

  double get width => double.parse(element.attributes["width"]);

  double get height => double.parse(element.attributes["height"]);

  void set x(double x) {
    element.attributes["x"] = "$x";
  }

  void set y(double y) {
    element.attributes["y"] = "$y";
  }

  void set width(double width) {
    element.attributes["width"] = "$width";
  }

  void set height(double height) {
    element.attributes["height"] = "$height";
  }
}
