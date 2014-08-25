part of boxy;

class ConnectorPath extends Widget {

  List listeners = [];

  Widget startWidget;
  num lastX1, lastX2, lastY1, lastY2;
  Widget endWidget;

  ConnectorPath(BoxyView boxy, this.startWidget, num startX, num startY) {
    element = new LineElement();

    element.attributes = {
      "x1": "$startX",
      "y1": "$startY",
      "x2": "$startX",
      "y2": "$startY",
      "stroke": "black",
      "stroke-width": "0.5"
    };

    boxy._SVG_CONTENT.append(element);

    listeners.add(boxy._SVG_ROOT.onMouseMove.listen((e) => updateLine(e)));

    this.lastX1 = startX;
    this.lastY1 = startY;
    this.subscribedEvents.add(this.startWidget.onTranslate.listen((dx, dy) => moveStartConnector(dx, dy)));
    this.subscribedEvents.add(this.startWidget.onResize.listen((dx, dy) => moveStartConnector(dx, dy)));
    this.subscribedEvents.add(this.startWidget.onUpdate.listen(() => updateCoordinates()));

    this.dragable = true;

  }

  void connectTo(Widget endWidget, num endX, num endY) {

    x2 = endX;
    y2 = endY;
    this.lastX2 = endX;
    this.lastY2 = endY;

    this.endWidget = endWidget;
    this.subscribedEvents.add(this.endWidget.onTranslate.listen((dx, dy) => moveEndConnector(dx, dy)));
    this.subscribedEvents.add(this.endWidget.onUpdate.listen(() => updateCoordinates()));

    // Remove listeners
    for (var listener in listeners) {
      listener.cancel();
    }
  }

  void moveStartConnector(num dx, num dy) {
    num newX = this.lastX1 + dx;
    num newY = this.lastY1 + dy;

    if (newX < startWidget.x) {
      x = startWidget.x;
    } else if (newX > startWidget.x + startWidget.width) {
      x = startWidget.x + startWidget.width;
    } else {
      x = newX;
    }

    if (newY < startWidget.y) {
      y = startWidget.y;
    } else if (newY > startWidget.y + startWidget.height) {
      y = startWidget.y + startWidget.height;
    } else {
      y = newY;
    }

  }

  void moveEndConnector(num dx, num dy) {
    num newX = this.lastX2 + dx;
    num newY = this.lastY2 + dy;

    if (newX < endWidget.x) {
      x2 = endWidget.x;
    } else if (newX > endWidget.x + endWidget.width) {
      x2 = endWidget.x + endWidget.width;
    } else {
      x2 = newX;
    }

    if (newY < endWidget.y) {
      y2 = endWidget.y;
    } else if (newY > endWidget.y + endWidget.height) {
      y2 = endWidget.y + endWidget.height;
    } else {
      y2 = newY;
    }
  }

  void updateLine(MouseEvent e) {
    x2 = e.offset.x;
    y2 = e.offset.y;
  }

  void updateCoordinates() {
    this.lastX1 = x;
    this.lastY1 = y;
    this.lastX2 = x2;
    this.lastY2 = y2;
  }

  num get x => num.parse(element.attributes["x1"]);

  num get x2 => num.parse(element.attributes["x2"]);

  num get cx => x + (width / 2);

  num get y => num.parse(element.attributes["y1"]);

  num get y2 => num.parse(element.attributes["y2"]);

  num get cy => y + (height / 2);

  num get width => x2 - x;

  num get height => y2 - y;

  set x(num x) => element.attributes["x1"] = "$x";

  set y(num y) => element.attributes["y1"] = "$y";

  set x2(num x) => element.attributes["x2"] = "$x";

  set y2(num y) => element.attributes["y2"] = "$y";

  set width(num width) => {};

  set height(num height) => {};

}
