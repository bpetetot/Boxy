part of boxy;

class ComposedWidgetBoxy extends Widget {

  final List<Widget> _children = [];

  final double startX;
  final double startY;
  final double startW;
  final double startH;

  ComposedWidgetBoxy(this.startX, this.startY, this.startW, this.startH) {
    this._createParentGroup();
  }

  ComposedWidgetBoxy.withChildren(this.startX, this.startY, this.startW, this.startH, List<Widget> children) {
    this._createParentGroup();
    children.forEach((w) => addChild(w));
  }

  void _createParentGroup() {
    element = new svg.GElement();
    element.attributes = {
      "x": "$startX",
      "y": "$startY",
      "width": "$startW",
      "height": "$startH",
      "vector-effect": "non-scaling-stroke"
    };
  }

  void addChild(Widget widget) {
    _children.add(widget);
  }

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, order);

    _children.forEach((w) => w.attach(element, order));

    udpateGroup();
  }

  void udpateGroup() {
    svg.Rect bbox = SvgUtils.getBBoxElements(_children.map((w) => w.element).toList());
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

  set x(double x) => element.attributes["x"] = "$x";

  set y(double y) => element.attributes["y"] = "$y";

  set width(double width) => element.attributes["width"] = "$width";

  set height(double height) => element.attributes["height"] = "$height";

  void updateCoordinates() {

    _children.forEach((w) {
      w.updateCoordinates();
    });

    super.updateCoordinates();
  }

}
