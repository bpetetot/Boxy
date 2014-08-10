part of boxy;

abstract class Widget {

  final SvgElement group = new SvgElement.tag("g");
  final SvgElement toolsGroup = new SvgElement.tag("g");

  SvgElement element;

  Draggable _draggable;
  Resizable _resizable;

  double get x;

  double get y;

  double get width;

  double get height;

  void set x(double x);

  void set y(double y);

  void set width(double width);

  void set height(double height);

  SvgSvgElement get svg => element.ownerSvgElement;

  void attach(SvgElement parent) {

    group.append(element);
    group.append(toolsGroup);
    
    parent.append(group);

    if (_draggable != null) {
      _draggable.init((curMouse, lastMouse) => dragWidget(curMouse, lastMouse));
    }

    if (_resizable != null) {
      _resizable.init();
    }
    
  }

  bool get resizable => _resizable != null;

  void set resizable(bool isResizable) {
    if (isResizable) {
      // Set widget resizable
      _resizable = new Resizable(this);
    } else {
      _resizable = null;
    }
  }

  bool get draggable => _draggable != null;

  void set draggable(bool isDraggable) {
    if (isDraggable) {
      // Set widget draggable
      _draggable = new Draggable(this);
    } else {
      _draggable = null;
    }
  }

  void dragWidget(Point curMouse, Point lastMouse) {

    // Convert the global point into the space of the object you are dragging
    Point pt = svg.createSvgPoint();
    pt.x = curMouse.x - lastMouse.x;
    pt.y = curMouse.y - lastMouse.y;

    pt = transformPointToElement(pt);

    x = x + pt.x;
    y = y + pt.y;

    if (resizable) {
      _resizable.updateAnchorPosition();
    }
  }

  Point transformPointToElement(Point point) {
    Matrix m = element.getTransformToElement(svg).inverse();
    m.e = 0;
    m.f = 0;

    return point.matrixTransform(m);
  }

}
