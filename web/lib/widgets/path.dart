part of boxy;


class PathBoxy extends Widget {

  String umlActor = "M40 20 C40 31.0457 31.0457 40 20 40 C8.9543 40 0 31.0457 0 20 C0 8.9543 8.9543 0 20 0 C31.0457 0 40 8.9543 40 20 ZM20 40 L20 75M20 75 L0 105M20 75 L40 105M2 60 L38 60";
  String umlNode = "M0 0 L12 -20 L112 -20 L112 75 L95 95 L95 0 ZM95 0 L112 -20";

  // TODO Complex shapes with groups

  final double startX;
  final double startY;
  final double startW;
  final double startH;

  PathBoxy(String name, this.startX, this.startY, this.startW, this.startH) {
    element = new svg.SvgElement.tag("path");
    element.attributes = {
      "stroke": "black",
      "fill": "white",
      "stroke-width": "1",
      "vector-effect": "non-scaling-stroke",
      "d": umlNode
    };
  }

  void attach(svg.SvgElement parent, int order) {
    this.order = order;
    parent.append(element);

    svg.Rect bbox = SvgUtils.getBBox(element);
    x = bbox.x;
    y = bbox.y;
    width = bbox.width;
    height = bbox.height;

    // Translate to initial coordinates
    translate(startX, startY);
    updateCoordinates();

    // Scale to initial height and width
    double rx = bbox.width * (startW / bbox.width) - bbox.width;
    double ry = bbox.height * (startH / bbox.height) - bbox.height;
    scale(rx, ry);
    updateCoordinates();
  }

  double get x => double.parse(element.attributes["x"]);

  double get cx => x + (width / 2);

  double get y => double.parse(element.attributes["y"]);

  double get cy => y + (height / 2);

  double get width => double.parse(element.attributes["width"]);

  double get height => double.parse(element.attributes["height"]);

  String get path => element.attributes["d"];

  set path(String path) => element.attributes["d"] = path;

  set x(double x) => element.attributes["x"] = "$x";

  set y(double y) => element.attributes["y"] = "$y";

  set width(double width) => element.attributes["width"] = "$width";

  set height(double height) => element.attributes["height"] = "$height";

  void updateCoordinates() {

    var position = SvgUtils.coordinateTransform(x, y, element);
    var position2 = SvgUtils.coordinateTransform(x + width, y + height, element);

    width = (position2.x - position.x).abs();
    height = (position2.y - position.y).abs();
    x = position.x;
    y = position.y;

    path = transformPath(path, element);

    element.attributes["transform"] = "";

    super.updateCoordinates();
  }


}
