part of boxy;

class Shape {

  double top;
  double left;
  double width;
  double height;

  SvgElement widget;
  SvgElement widgetGroup;
  SvgSvgElement parent;

  Resizable resizable;

  Shape(this.left, this.top, this.width, this.height);

  // ---- Create Widget

  SvgElement createWidget(SvgSvgElement svgView) {
    parent = svgView;

    // Create Widget Group
    widgetGroup = new SvgElement.tag("g");

    // Create Widget
    widget = new SvgElement.tag("rect");
    widget.attributes = {
      "x": "$left",
      "y": "$top",
      "width": "$width",
      "height": "$height",
      "stroke": "black",
      "fill": "transparent",
      "stroke-width": "1"
    };

    widgetGroup.append(widget);

    // Set widget draggable
    Draggable draggable = new Draggable(widget, parent, (curMouse, lastMouse) => onDrag(curMouse, lastMouse));

    // Set widget resizable
    resizable = new Resizable(widget, parent, widgetGroup);

    return widgetGroup;
  }

  void onDrag(Point curMouse, Point lastMouse) {

    // Convert the global point into the space of the object you are dragging
    Point pt = parent.createSvgPoint();
    pt.x = curMouse.x - lastMouse.x;
    pt.y = curMouse.y - lastMouse.y;

    Matrix m = widget.getTransformToElement(parent).inverse();
    m.e = 0;
    m.f = 0;

    pt = pt.matrixTransform(m);

    double newX = double.parse(widget.attributes["x"]) + pt.x;
    double newY = double.parse(widget.attributes["y"]) + pt.y;

    widget.attributes["x"] = "$newX";
    widget.attributes["y"] = "$newY";

    resizable.moveBoxToParent();
  }



}
