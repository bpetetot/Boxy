part of boxy;

class Connector {

  ConnectorManager manager;

  Widget widget;

  SvgElement element;

  Connector(this.widget, this.manager) {
    element = new RectElement();

    element.attributes = {
      "stroke": "red",
      "stroke-width": "1",
      "height": "3",
      "width": "3",
      "x": "${this.widget.cx}",
      "y": "${this.widget.cy}",
      "fill": "transparent",
      "vector-effect": "non-scaling-stroke",
      "shape-rendering": "auto"
    };

    // start connector creation
    element.onMouseUp.listen((e) => manager.onConnect(this));

    // listen widget updates
    widget.addTranslateListener((dx, dy) => translate(dx, dy));
    widget.addUpdateListener((x, y) => update(x, y));

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

  void update(num x, num y) {
    element.attributes["x"] = "${this.widget.cx}";
    element.attributes["y"] = "${this.widget.cy}";
    element.attributes["transform"] = "";
  }

  void attach(GElement view) {
    view.append(element);
  }

  void dettach() {
    element.remove();
  }

}
