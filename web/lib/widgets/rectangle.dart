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
      "stroke-width": "1",
      "vector-effect" : "non-scaling-stroke"
    };

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
