part of boxy;

abstract class Widget {

  SvgElement element;
  SvgElement _group;

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
  
  void createWidget(SvgSvgElement svgView) {

    // Create Widget Group
    _group = new SvgElement.tag("g");
    SvgElement elementGroup = new SvgElement.tag("g");
    SvgElement toolsGroup = new SvgElement.tag("g");

    elementGroup.append(element);
    _group.append(elementGroup);
    _group.append(toolsGroup);

    svgView.append(_group);

    // Set element draggable
    _draggable = new Draggable(elementGroup, (curMouse, lastMouse) => onDrag(curMouse, lastMouse));

    // Set element resizable
    _resizable = new Resizable(this, toolsGroup);

  }

  void onDrag(Point curMouse, Point lastMouse) {

    // Convert the global point into the space of the object you are dragging
    Point pt = svg.createSvgPoint();
    pt.x = curMouse.x - lastMouse.x;
    pt.y = curMouse.y - lastMouse.y;

    pt = transformPointToElement(pt);

    x = x + pt.x;
    y = y + pt.y;

    if (_resizable != null) {
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
