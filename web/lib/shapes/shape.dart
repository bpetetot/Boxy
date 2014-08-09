part of boxy;

class Shape {

  double top;
  double left;
  double width;
  double height;

  SvgElement widget;
  SvgElement widgetGroup;
  SvgSvgElement parent;

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
    Draggable draggable = new Draggable(widget, parent, (newX, newY) => onDrag(newX, newY));

    // Set widget resizable
    Resizable resizable = new Resizable(widget, parent, widgetGroup);
    
    return widgetGroup;
  }

  void onDrag(double x, double y) {
    widgetGroup.setAttribute("transform", "translate(${x}, ${y})");
  }

  

}
