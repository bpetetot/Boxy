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
  
  set ray(double ray) => element.attributes["r"] = "${ray}";

  set x(double x) => element.attributes["cx"] = "${x + ray}";

  set y(double y) => element.attributes["cy"] = "${y + ray}";

  set width(double width) => ray = width / 2;

  set height(double height) => ray = height / 2;

}
