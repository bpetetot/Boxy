part of boxy;


class PathBoxy extends Widget {

  final String _path;

  double _startX;
  double _startY;
  double _startW;
  double _startH;

  PathBoxy.fromPath(this._path) {
    this.createPath();
  }

  PathBoxy(this._path, this._startX, this._startY, this._startW, this._startH) {
    this.createPath();
  }

  void createPath() {
    element = new svg.SvgElement.tag("path");
    element.attributes = {
      "stroke": "black",
      "fill": "white",
      "stroke-width": "1",
      "vector-effect": "non-scaling-stroke",
      "d": _path
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
    if (_startX != null && _startY != null) {
      translate(_startX, _startY);
      updateCoordinates();
    }

    // Scale to initial height and width
    if (_startW != null && _startH != null) {
      double rx = bbox.width * (_startW / bbox.width) - bbox.width;
      double ry = bbox.height * (_startH / bbox.height) - bbox.height;
      scale(rx, ry);
      updateCoordinates();
    }
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
