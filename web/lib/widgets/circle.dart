part of boxy;

class CircleBoxy extends Widget {

  CircleBoxy(double cx, double cy, double ray) {
    element = new SvgElement.tag("circle");
    element.attributes = {
      "cx": "$cx",
      "cy": "$cy",
      "r": "$ray",
      "stroke": "black",
      "fill": "white",
      "stroke-width": "1"
    };
  }

  double get ray => double.parse(element.attributes["r"]);
  
  double get x => double.parse(element.attributes["cx"]) - ray;

  double get y => double.parse(element.attributes["cy"]) - ray;

  double get width => ray * 2;

  double get height => ray * 2;

  void set x(double x) {
    element.attributes["cx"] = "${x + ray}";
  }

  void set y(double y) {
    element.attributes["cy"] = "${y + ray}";
  }

  void set width(double width) {
    element.attributes["r"] = "${width / 2}";
  }

  void set height(double height) {
    element.attributes["r"] = "${height / 2}";
  }

}
