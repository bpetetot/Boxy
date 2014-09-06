part of boxy;

class MultiRubber extends SelectorItem {

  static final double _LINE_WIDTH = 1.5;
  static final String _COLOR = "green";
  static final String _CURSOR = "move";

  MultiRubber(String selectorName, List<Widget> selectedWidgets) : super(selectedWidgets) {

    this.selectorName = selectorName;

    element = new svg.RectElement();

    element.attributes = {
      "id": selectorName,
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "stroke-dasharray": "10 5",
      "cursor": _CURSOR,
      "fill": "transparent",
      "vector-effect": "non-scaling-stroke",
      "shape-rendering": "auto"
    };

    updateCoordinates();
  }

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, 0);
    widgets.forEach((w) => w.onTranslate.listen((e) => translate(e.dx, e.dy)));
  }

  void onDrag(SelectorDragEvent e) {
    widgets.forEach((w) => w.translate(e.dx, e.dy));
  }

  void onDragEnd(SelectorDragEvent e) {
    widgets.forEach((w) => w.updateCoordinates());
    updateCoordinates();
  }

  void updateCoordinates() {

    svg.Rect widgetBBox = SvgUtils.getBBoxElements(widgets.map((w) => w.element).toList());
    x = widgetBBox.x - 3;
    y = widgetBBox.y - 3;
    width = widgetBBox.width + 6;
    height = widgetBBox.height + 6;

    onUpdate.add(new UpdateEvent());
    element.attributes["transform"] = "";
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
