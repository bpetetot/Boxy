part of boxy;

class Connector {

  ConnectorManager manager;

  Widget widget;

  SvgElement element;

  Connector(this.widget, this.manager) {
    element = new RectElement();

    element.attributes = {
      "stroke": "blue",
      "stroke-width": "1",
      "height": "5",
      "width": "5",
      "x": "${this.widget.cx - 2.5}",
      "y": "${this.widget.cy - 2.5}",
      "fill": "transparent",
      "vector-effect": "non-scaling-stroke",
      "shape-rendering": "auto"
    };

    // start connector creation
    element.onMouseUp.listen((e) => manager.onConnect(this));
    element.onMouseOver.listen((e) => element.attributes["fill"] = "blue");
    element.onMouseOut.listen((e) => element.attributes["fill"] = "transparent");

    // listen widget updates
    widget.onTranslate.listen((dx, dy) => translate(dx, dy));
    widget.onUpdate.listen(() =>update());

  }

  List<dynamic> translateListeners = [];

  void addTranslateListener(void onTranslate(x, y)) {
    translateListeners.add((x, y) => onTranslate(x, y));
  }

  void translate(num dx, num dy) {
    element.attributes["transform"] = "translate(${dx}, ${dy})";

    for (dynamic listener in translateListeners) {
      listener(dx, dy);
    }
  }

  void update() {
    element.attributes["x"] = "${this.widget.cx - 2.5}";
    element.attributes["y"] = "${this.widget.cy - 2.5}";
    element.attributes["transform"] = "";
  }

  void attach(GElement view) {
    view.append(element);
  }

  void dettach() {
    element.remove();
  }

}
