part of boxy;

class MoveHandler extends WidgetHandler {

  static final double _LINE_WIDTH = 1.5;
  static final String _COLOR = "blue";
  static final String _CURSOR = "move";

  MoveHandler.forWidget(String handlerName, Widget widget) : super.forWidget(widget) {
    this.createMoveHandler(handlerName);
  }

  MoveHandler.forWidgets(String handlerName, List<Widget> widgets) : super.forWidgets(widgets) {
    this.createMoveHandler(handlerName);
  }

  void createMoveHandler(String handlerName) {
    this.handlerName = handlerName;

    element = new svg.RectElement();

    element.attributes = {
      "id": handlerName,
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "stroke-dasharray": "10 5",
      "cursor": _CURSOR,
      "fill": "transparent",
      "vector-effect": "non-scaling-stroke",
      "shape-rendering": "auto"
    };
  }

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, 0);

    updateCoordinates();

    widgets.forEach((w) => subscribedEvents.add(w.onTranslate.listen((e) => translate(e.dx, e.dy))));
    widgets.forEach((w) => subscribedEvents.add(w.onResize.listen((e) => scale(e.dx, e.dy))));
    widgets.forEach((w) => subscribedEvents.add(w.onUpdate.listen((e) => updateCoordinates())));
  }

  void onDrag(HandlerDragEvent e) {
    widgets.forEach((w) => w.translate(e.dx, e.dy));
  }

  void onDragEnd(HandlerDragEvent e) {
    widgets.forEach((w) => w.updateCoordinates());
    updateCoordinates();
  }

  void updateCoordinates() {

    svg.Rect widgetBBox = SvgUtils.getBBoxElements(widgets.map((w) => w.element).toList());

    x = widgetBBox.x - 3;
    y = widgetBBox.y - 3;
    width = widgetBBox.width + 6;
    height = widgetBBox.height + 6;

    element.attributes["transform"] = "";

    super.updateCoordinates();
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
