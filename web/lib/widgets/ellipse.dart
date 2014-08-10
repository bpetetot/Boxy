part of boxy;

class EllipseBoxy extends Widget {

  EllipseBoxy(double cx, double cy, double rx, double ry) {
    element = new SvgElement.tag("ellipse");
    element.attributes = {
      "cx": "$cx",
      "cy": "$cy",
      "rx": "$rx",
      "ry": "$ry",
      "stroke": "black",
      "fill": "white",
      "stroke-width": "1"
    };
  }

  double get rx => double.parse(element.attributes["rx"]);
  
  double get ry => double.parse(element.attributes["ry"]);

  double get x => double.parse(element.attributes["cx"]) - rx;

  double get y => double.parse(element.attributes["cy"]) - ry;

  double get width => rx * 2;

  double get height => ry * 2;
  
  set rx(double rx) => element.attributes["rx"] = "${rx}";
  
  set ry(double ry) => element.attributes["ry"] = "${ry}";

  set x(double x) => element.attributes["cx"] = "${x + rx}";

  set y(double y) => element.attributes["cy"] = "${y + ry}";

  set width(double width) => rx = width / 2;

  set height(double height) => ry = height / 2;

}
