part of boxy;

class ConnectorPath {

  SvgElement path;

  Connector start;
  Connector end;

  var _lastMouse;
  
  List listeners = [];

  ConnectorPath(this.start) {
    path = new LineElement();

    path.attributes = {
      "x1": start.element.attributes["x"],
      "y1": start.element.attributes["y"],
      "x2": start.element.attributes["x"],
      "y2": start.element.attributes["y"],
      "stroke": "black",
      "stroke-width": "0.5"
    };

    start.element.parent.append(path);
    
    start.addTranslateListener((x,y) => moveStart(x, y));

    listeners.add(path.ownerSvgElement.ownerSvgElement.onMouseMove.listen((e) => updateLine(e)));

    _lastMouse = path.ownerSvgElement.createSvgPoint();
    _lastMouse.x = double.parse(start.element.attributes["x"]);
    _lastMouse.y = double.parse(start.element.attributes["y"]);
  }

  void connectTo(Connector connect) {
    this.end = connect;
    
    end.addTranslateListener((x,y) => moveEnd(x, y));
    
    path.attributes["x2"] = end.element.attributes["x"];
    path.attributes["y2"] = end.element.attributes["y"];
   
     // Remove listeners
     for (var listener in listeners) {
       listener.cancel();
     }
  }
  
  void moveStart(num dx, num dy) {
    path.attributes["x1"] = "${double.parse(start.element.attributes["x"]) + dx}";
    path.attributes["y1"] = "${double.parse(start.element.attributes["y"]) + dy}";
  }
  
  void moveEnd(num dx, num dy) {
    path.attributes["x2"] = "${double.parse(end.element.attributes["x"]) + dx}";
    path.attributes["y2"] = "${double.parse(end.element.attributes["y"]) + dy}";
  }

  void updateLine(MouseEvent e) {

    path.attributes["x2"] = "${e.offset.x}";
    path.attributes["y2"] = "${e.offset.y}";

    _lastMouse.x = e.offset.x;
    _lastMouse.y = e.offset.y;

  }

}
